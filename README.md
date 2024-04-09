# Elmkdir

create windows' folder with unique prefix name


## Installation

### Folder Configuration
add file `/config/config.secrets.exs`

```/config/config.secrets.exs
import Config
config :tzdata, data_dir: "YOUR_PROJECT_PATH/_build/dev/lib/tzdata/priv/_build/dev/lib/elmkdir"
config :elmkdir, parent_dir: "YOUR_PARENT_FOLDER", folder_link_file_dir: "YOUR_LINK_FILE_FOLDER"
```

### Install
```bash
mix escript.install
```

### Path Settings
add `HOME\.mix\escripts` to PATH.

### Execute program

#### create folder and open it by explorer
```bash
elmkdir -e folder_name
```
#### create folder and open it by VSCode
```bash
elmkdir -e folder_name
```

