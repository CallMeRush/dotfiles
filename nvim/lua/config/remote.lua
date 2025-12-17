function CopyDirToRemote()
    local local_dir = vim.fn.getcwd()
    local local_without_home = string.sub(local_dir, #os.getenv("HOME") + 2)
    local local_without_home_and_last = vim.fn.fnamemodify(local_without_home, ":h")

    local remote_user = "a84426610"
    local remote_host = "71.14.10.104"
    local remote_home = "/home/" .. remote_user .. "/"
    local remote_dir = remote_home .. local_without_home_and_last .. "/"
    local remote_path = string.format("%s@%s:%s", remote_user, remote_host, remote_dir)
    
    -- vim.notify("Directory to sync from: " .. local_dir, vim.log.levels.INFO)
    -- vim.notify("Directory to sync to: " .. remote_path, vim.log.levels.INFO)

    local cmd = {
        "rsync", "-av", "--progress",
        "--exclude='.git'",  -- Optional: exclude .git directory
        "--exclude='*.swp'", -- Optional: exclude swap files
        local_dir,
        remote_path
    }

    local job = vim.fn.jobstart(cmd, {
        on_exit = function(_, exit_code, _)
            if exit_code == 0 then
                vim.notify("✅ Directory synced successfully to " .. remote_host, vim.log.levels.INFO)
            else
                vim.notify("❌ rsync failed (exit code: " .. exit_code .. ")", vim.log.levels.ERROR)
            end
        end,
        stdout_buffered = true,
        stderr_buffered = true,
    })
    
    if job <= 0 then
        vim.notify("❌ Failed to start rsync job", vim.log.levels.ERROR)
    else
        vim.notify("🔄 Syncing directory to " .. remote_path, vim.log.levels.INFO)
    end
end

function CopyFileToRemote()
    local local_file = vim.api.nvim_buf_get_name(0)
    local local_without_home = string.sub(local_file, #os.getenv("HOME") + 2)

    local remote_user = "a84426610"
    local remote_host = "71.14.10.104"
    local remote_home = "/home/" .. remote_user .. "/"
    local remote_dir = remote_home .. local_without_home
    local remote_path = string.format("%s@%s:%s", remote_user, remote_host, remote_dir)
    
    -- vim.notify("Directory to sync from: " .. local_file, vim.log.levels.INFO)
    -- vim.notify("Directory to sync to: " .. remote_path, vim.log.levels.INFO)

    local cmd = {
        "rsync", "-av", "--progress",
        "--exclude='.git'",  -- Optional: exclude .git directory
        "--exclude='*.swp'", -- Optional: exclude swap files
        local_file,
        remote_path
    }

    local job = vim.fn.jobstart(cmd, {
        on_exit = function(_, exit_code, _)
            if exit_code == 0 then
                vim.notify("✅ File synced successfully to " .. remote_host, vim.log.levels.INFO)
            else
                vim.notify("❌ rsync failed (exit code: " .. exit_code .. ")", vim.log.levels.ERROR)
            end
        end,
        stdout_buffered = true,
        stderr_buffered = true,
    })
    
    if job <= 0 then
        vim.notify("❌ Failed to start rsync job", vim.log.levels.ERROR)
    else
        vim.notify("🔄 Syncing file to " .. remote_path, vim.log.levels.INFO)
    end
end

-- Copy whole directory remotely
vim.api.nvim_create_user_command('WAR', function(opts) 
    local success, err = pcall(vim.cmd, "silent! wa")
    CopyDirToRemote()
end, {})

-- Copy single file remotely
vim.api.nvim_create_user_command('WR', function(opts) 
    local success, err = pcall(vim.cmd, "silent! w")
    CopyFileToRemote()
end, {})

