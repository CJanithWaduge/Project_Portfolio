#!/usr/bin/env sh
# ===========================================================================
#  Local preview server for the portfolio.
#
#  Why this exists:
#    Browsers block fetch() of local files when a page is opened with the
#    file:// protocol, so index.html cannot read Home.json / Projects.json /
#    Blog.json if you just double-click it. Serving the folder over HTTP
#    fixes that, and this script picks whatever server you already have.
#
#  Usage:  ./preview.sh            (serves on http://localhost:8000)
#          ./preview.sh 3000       (serves on http://localhost:3000)
# ===========================================================================

PORT="${1:-8000}"
URL="http://localhost:$PORT"

open_browser() {
    sleep 1
    if command -v xdg-open >/dev/null 2>&1; then xdg-open "$URL" >/dev/null 2>&1
    elif command -v open >/dev/null 2>&1; then open "$URL" >/dev/null 2>&1
    fi
}

echo
echo "  Portfolio local preview"
echo "  -----------------------"
echo "  Serving:  $URL"
echo "  Stop:     Ctrl+C"
echo

if command -v python3 >/dev/null 2>&1; then
    open_browser &
    exec python3 -m http.server "$PORT"
elif command -v python >/dev/null 2>&1; then
    open_browser &
    exec python -m http.server "$PORT"
elif command -v npx >/dev/null 2>&1; then
    open_browser &
    exec npx --yes serve -l "$PORT" .
else
    echo "  Could not find python3 or npx."
    echo "  Install Python 3 or Node.js, then run ./preview.sh again."
    echo "  Or just open the live site:"
    echo "    https://cjanithwaduge.github.io/Project_Portfolio/"
    exit 1
fi
