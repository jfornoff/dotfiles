# --- Colors ---
COLOR_RESET='\033[0m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[0;33m'
COLOR_BLUE='\033[0;34m'
COLOR_CYAN='\033[0;36m'

# --- Helper Functions ---
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

print_header() {
    echo -e "\n${COLOR_BLUE}--- $1 ---${COLOR_RESET}"
}

print_success() {
    echo -e "${COLOR_GREEN}✔ $1${COLOR_RESET}"
}

print_info() {
    echo -e "${COLOR_CYAN}ℹ $1${COLOR_RESET}"
}

print_warning() {
    echo -e "${COLOR_YELLOW}⚠ $1${COLOR_RESET}"
}
