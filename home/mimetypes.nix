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

      # Automatically map all common image types to Gwenview
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
     ] (name: "org.kde.gwenview.desktop"))

    # Automatically map all common office files to OnlyOffice
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

    # Automatically map generic text and code files to Kate
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
     ] (name: "org.kde.kate.desktop"));


  };

}
