# 📄 PDF Compressor Script
## 📝 Description
A smart bash script that automatically compresses PDF files using Ghostscript, maintaining organized directories for compressed and original files. The script intelligently keeps compressed versions only when size reduction is achieved. 🎯

## ✨ Features
🔄 Batch PDF compression

📊 Automatic file size comparison

📁 Organized directory structure

🎚️ Configurable compression levels

🧹 Automatic cleanup of unsuccessful compressions

## 🛠️ Prerequisites
### For Debian/Ubuntu
```bash
sudo apt-get install ghostscript
```
### For Fedora
```bash
sudo dnf install ghostscript
```
## 🚀 Usage
```bash
./compress_pdf.sh
```
## ⚙️ Compression Settings
```bash
# Available PDFSETTINGS options:
/screen    # Lowest quality, smallest size
/ebook     # Medium quality
/printer   # High quality
/prepress  # Maximum quality
/default   # Balanced setting
```
## 📂 Directory Structure
.

├── compressed_pdfs/    # Compressed PDFs

└── original_pdfs/      # Original files

## ⚠️ Notes
Processes all PDFs in current directory
Keeps originals only if compression succeeds
Compression quality depends on PDFSETTINGS
Creates "_compressed.pdf" suffix
