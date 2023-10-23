local ok, harpoon = pcall(require, "harpoon")
if not ok then
    return
end

harpoon.setup({
    nav_first_in_list = true,
    --projects = {
    --    ["/home/hendrik/workspace/quokka-backend"] = {
    --        term = {
    --            cmds = {
    --                " from terminal harpoon?"",
    --            }
    --        }
    --    }
    --}
})
