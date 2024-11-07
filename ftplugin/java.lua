-- Configurando LSP
local jdtls = require("jdtls")
local home = vim.fn.expand("~")
local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls";
local javadbg_path = vim.fn.stdpath("data") .. "/mason/packages/java-debug-adapter";
local javatest_path = vim.fn.stdpath("data") .. "/mason/packages/java-test";

local bundles = {
  vim.fn.glob(javadbg_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", true),
}

vim.list_extend(bundles, vim.split(vim.fn.glob(javatest_path .. "/extension/server/*.jar", 1), "\n"))

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
    "-data", home .. "/workspace/sandbox/.jdtls"
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
  init_options = {
    bundles = bundles
  },
  on_attach = function(client, bufnr)
    jdtls.setup_dap({ hotcodereplace = "auto" })
    vim.keymap.set("n", "<leader>o", jdtls.organize_imports, { desc = "Organize imports", buffer = bufnr })
  end
})
