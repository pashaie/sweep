# Install dependencies & build tools
sudo apt-get update
sudo apt-get -y install gcc-mingw-w64-x86-64 gcc-mingw-w64-i686
rustup target add x86_64-pc-windows-gnu
rustup target add i686-pc-windows-gnu
rustup target add x86_64-unknown-linux-gnu

# Prepare dirs
mkdir dist
mkdir builds

# Win64
cargo rustc --release --target=x86_64-pc-windows-gnu -- -C linker=x86_64-w64-mingw32-gcc
mkdir builds/project-cleanup-win64
cp target/x86_64-pc-windows-gnu/release/project-cleanup.exe builds/project-cleanup-win64
tar -C builds -czvf dist/project-cleanup-win64.tar.gz project-cleanup-win64

# Win32
cargo rustc --release --target=i686-pc-windows-gnu -- -C linker=i686-w64-mingw32-gcc -C link-args=-mwindows -C panic=abort
mkdir builds/project-cleanup-win32
cp target/i686-pc-windows-gnu/release/project-cleanup.exe builds/project-cleanup-win32
tar -C builds -czvf dist/project-cleanup-win32.tar.gz project-cleanup-win32

# Linux
cargo rustc --release --target=x86_64-unknown-linux-gnu
mkdir builds/project-cleanup-linux
cp target/x86_64-unknown-linux-gnu/release/project-cleanup builds/project-cleanup-linux
tar -C builds -czvf dist/project-cleanup-linux.tar.gz project-cleanup-linux