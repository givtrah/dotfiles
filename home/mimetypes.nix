{ config, lib, pkgs, ...}: {

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = "okularApplication_pdf.desktop";


			# Default browser
			"text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";

      # Map common image types to Oculante
     } // (lib.genAttrs [
       "image/png"
       "image/jpeg"
       "image/jpg"
       "image/gif"
       "image/webp"
       "image/bmp"
       "image/tiff"
       "image/svg+xml"
       "image/x-xcf"          # GIMP images
       "image/vnd.adobe.photoshop" # PSD files
       "image/heic"           # Apple photos
       "image/avif"           # Next-gen web images
#     ] (name: "org.kde.gwenview.desktop"))
      ] (name: "oculante.desktop"))

     # Map common office files to OnlyOffice
     // (lib.genAttrs [
       # Microsoft Office formats
       "application/msword"                                                      # .doc
       "application/vnd.openxmlformats-officedocument.wordprocessingml.document" # .docx
       "application/vnd.ms-excel"                                                # .xls
       "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"       # .xlsx
       "application/vnd.ms-powerpoint"                                           # .ppt
       "application/vnd.openxmlformats-officedocument.presentationml.presentation" # .pptx

       # OpenDocument / LibreOffice formats
       "application/vnd.oasis.opendocument.text"                                 # .odt
       "application/vnd.oasis.opendocument.spreadsheet"                          # .ods
       "application/vnd.oasis.opendocument.presentation"                         # .odp
       
       # Generic text types handled well by Office suites
       "application/rtf"                                                         # Rich Text
       "text/csv"                                                                # Comma-separated values
     ] (name: "org.onlyoffice.desktopeditors.desktop"))

     # Map generic text and code files to Kate
     // (lib.genAttrs [
       "text/plain"                  # Standard text files (.txt)
       "text/markdown"               # Markdown files (.md)
       "text/vtt"                    # Subtitles (.vtt)
       "application/x-zerosize"      # Empty files
       
       # Code, config, and script files (fallback handling)
       "text/x-chdr"                 # C/C++ Headers
       "text/x-csrc"                 # C Source
       "text/x-c++src"               # C++ Source
       "application/json"            # JSON files
       "application/xml"             # XML files
       "application/x-shellscript"   # Bash/Shell scripts (.sh)
       "text/x-python"               # Python files (.py)
     ] (name: "org.kde.kate.desktop"))

     # Map archive formats to Ark
     // (lib.genAttrs [
       "application/zip"             # .zip
       "application/x-7z-compressed" # .7z
       "application/vnd.rar"         # .rar
       "application/x-rar"           # Fallback .rar
       "application/x-tar"           # .tar
       "application/x-compressed-tar" # .tar.gz / .tgz
       "application/x-bzip2-compressed-tar" # .tar.bz2
       "application/x-xz-compressed-tar" # .tar.xz
       "application/x-gzip"          # .gz
       "application/x-bzip2"         # .bz2
       "application/x-xz"            # .xz
       "application/x-cpio"          # .cpio
     ] (name: "org.kde.ark.desktop"))

     # Map video files to mpv
     // (lib.genAttrs [
       "video/mp4"                   # .mp4
       "video/webm"                  # .webm
       "video/x-matroska"            # .mkv
       "video/quicktime"             # .mov
       "video/x-msvideo"             # .avi
       "video/x-flv"                 # .flv
       "video/ogg"                   # .ogv
       "video/mp2t"                  # .ts
       "video/mpeg"                  # .mpeg / .mpg
       "video/x-ms-wmv"              # .wmv
     ] (name: "mpv.desktop"))           

      # Map audio files to fooyin
      // (lib.genAttrs [
        "audio/mp4"                    # AAC / MP4 Audio (.m4a)
        "audio/mpeg"                   # MP3 Audio (.mp3)
        "audio/ogg"                    # Ogg Vorbis (.ogg)
        "audio/x-flac"                 # FLAC Audio (.flac)
        "audio/x-mp3"                  # Alternative MP3 Mimetype
        "audio/x-mpeg"                 # Alternative MPEG Audio Mimetype
        "audio/x-vorbis+ogg"           # Alternative Ogg Vorbis Mimetype
        "audio/x-wav"                  # Waveform Audio (.wav)
        "audio/x-opus+ogg"             # Opus Audio (.opus)
        "audio/x-m4a"                  # Alternative M4A Mimetype
        "audio/x-matroska"             # Matroska Audio (.mka)
        "audio/aac"                    # Raw AAC stream (.aac)
      ] (name: "fooyin.desktop")); 

  };
}
