
### Export Keybindings and Settings to Current Project Directory

#### Windows

1. **Open Command Prompt or PowerShell**:
   - Press `Win + R`, type `cmd` or `powershell`, and press `Enter`.

2. **Navigate to your project directory**:
   ```bash
   cd path\to\your\project\directory
   ```

3. **Export Keybindings**:
   ```bash
   copy "%APPDATA%\Code\User\keybindings.json" "keybindings.json"
   ```

4. **Export Settings**:
   ```bash
   copy "%APPDATA%\Code\User\settings.json" "settings.json"
   ```

#### macOS

1. **Open Terminal**:
   - Press `Cmd + Space`, type `Terminal`, and press `Enter`.

2. **Navigate to your project directory**:
   ```bash
   cd /path/to/your/project/directory
   ```

3. **Export Keybindings**:
   ```bash
   cp ~/Library/Application\ Support/Code/User/keybindings.json ./keybindings.json
   ```

4. **Export Settings**:
   ```bash
   cp ~/Library/Application\ Support/Code/User/settings.json ./settings.json
   ```

#### Linux

1. **Open Terminal**:
   - Depending on your distribution, you can typically find the terminal in the system menu or by pressing `Ctrl + Alt + T`.

2. **Navigate to your project directory**:
   ```bash
   cd /path/to/your/project/directory
   ```

3. **Export Keybindings**:
   ```bash
   cp ~/.config/Code/User/keybindings.json ./keybindings.json
   ```

4. **Export Settings**:
   ```bash
   cp ~/.config/Code/User/settings.json ./settings.json
   ```

### Import Keybindings and Settings from Current Project Directory

#### Windows

1. **Open Command Prompt or PowerShell**:
   - Press `Win + R`, type `cmd` or `powershell`, and press `Enter`.

2. **Navigate to your project directory**:
   ```bash
   cd path\to\your\project\directory
   ```

3. **Import Keybindings**:
   ```bash
   copy "keybindings.json" "%APPDATA%\Code\User\keybindings.json"
   ```

4. **Import Settings**:
   ```bash
   copy "settings.json" "%APPDATA%\Code\User\settings.json"
   ```

#### macOS

1. **Open Terminal**:
   - Press `Cmd + Space`, type `Terminal`, and press `Enter`.

2. **Navigate to your project directory**:
   ```bash
   cd /path/to/your/project/directory
   ```

3. **Import Keybindings**:
   ```bash
   cp ./keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
   ```

4. **Import Settings**:
   ```bash
   cp ./settings.json ~/Library/Application\ Support/Code/User/settings.json
   ```

#### Linux

1. **Open Terminal**:
   - Depending on your distribution, you can typically find the terminal in the system menu or by pressing `Ctrl + Alt + T`.

2. **Navigate to your project directory**:
   ```bash
   cd /path/to/your/project/directory
   ```

3. **Import Keybindings**:
   ```bash
   cp ./keybindings.json ~/.config/Code/User/keybindings.json
   ```

4. **Import Settings**:
   ```bash
   cp ./settings.json ~/.config/Code/User/settings.json
   ```

### Example Workflow

#### Exporting (On Your Current System)

1. Navigate to your project directory:
   ```bash
   cd /path/to/your/project/directory
   ```

2. Run the export commands.

#### Importing (On Your New System)

1. Navigate to your project directory:
   ```bash
   cd /path/to/your/project/directory
   ```

2. Run the import commands.

