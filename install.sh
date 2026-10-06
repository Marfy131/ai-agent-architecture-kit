#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR=""
SYMLINK=false
FORCE=false

usage() {
  cat <<EOF
Usage: $(basename "$0") [OPTIONS] [TARGET_DIR]

Install portable skills and AGENTS.md into a target repository.

Options:
  -s, --symlink    Create symbolic links instead of copying skills
  -f, --force      Overwrite existing AGENTS.md in the target directory
  -h, --help       Show this help message

Arguments:
  TARGET_DIR       Destination directory (defaults to current working directory)
EOF
  exit 0
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -s|--symlink)
      SYMLINK=true
      shift
      ;;
    -f|--force)
      FORCE=true
      shift
      ;;
    -h|--help)
      usage
      ;;
    -*)
      echo "Unknown option: $1" >&2
      usage
      ;;
    *)
      if [[ -z "$TARGET_DIR" ]]; then
        TARGET_DIR="$1"
      else
        echo "Unexpected argument: $1" >&2
        usage
      fi
      shift
      ;;
  esac
done

TARGET_DIR="${TARGET_DIR:-$PWD}"

mkdir -p "$TARGET_DIR/.agents"

if [[ "$SYMLINK" == true ]]; then
  if [[ -e "$TARGET_DIR/.agents/skills" ]]; then
    rm -rf "$TARGET_DIR/.agents/skills"
  fi
  ln -s "$SOURCE_DIR/.agents/skills" "$TARGET_DIR/.agents/skills"
  echo "Symlinked skills: $TARGET_DIR/.agents/skills -> $SOURCE_DIR/.agents/skills"
else
  mkdir -p "$TARGET_DIR/.agents/skills"
  cp -R "$SOURCE_DIR/.agents/skills/." "$TARGET_DIR/.agents/skills/"
  echo "Copied portable skills under $TARGET_DIR/.agents/skills"
fi

if [[ -e "$TARGET_DIR/AGENTS.md" ]] && [[ "$FORCE" == false ]]; then
  echo "Kept existing $TARGET_DIR/AGENTS.md"
  echo "Merge the non-negotiable rules from $SOURCE_DIR/AGENTS.md manually (or use --force to overwrite)."
else
  cp "$SOURCE_DIR/AGENTS.md" "$TARGET_DIR/AGENTS.md"
  echo "Installed AGENTS.md in $TARGET_DIR"
fi

echo "Installation complete."
echo "See $SOURCE_DIR/README.md for Dirac, OpenCode, Oh My Pi, Antigravity, and scoped AGENTS.md setup."
