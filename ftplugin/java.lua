-- Configurando LSP
local jdtls = require("jdtls")
local home = vim.fn.expand("~")
local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls";

local function organize_and_format()
  jdtls.organize_imports()
  jdtls.format()
end

jdtls.start_or_attach({
  cmd = {
    home .. "/.asdf/installs/java/adoptopenjdk-17.0.9+9/bin/java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1g",
    "-javaagent:" .. jdtls_path .. "/lombok.jar",
    "-jar", vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
    "-configuration", jdtls_path .. "/config_linux",
    "-data", home .. "/workspace/sandbox"
  },
  root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew", "pom.xml" }),
  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = "JavaSE-1.8",
            path = home .. "/.asdf/installs/java/adoptopenjdk-8.0.412+8/",
          },
          {
            name = "JavaSE-11",
            path = home .. "/.asdf/installs/java/adoptopenjdk-11.0.9+11/";
          },
          {
            name = "JavaSE-17",
            path = home .. "/.asdf/installs/java/adoptopenjdk-17.0.9+9/";
          },
        }
      }
    }
  },
  on_attach = function(client, bufnr)
    local opts = { silent = true, buffer = bufnr }
    vim.keymap.set("n", "<leader>of", organize_and_format, { desc = "Organize imports and format code", buffer = bufnr })
  end
})
