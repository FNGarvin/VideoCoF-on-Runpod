# Set variables for easy modification
INPUT_FILE="gen_beachdance_compare.mp4"
OUTPUT_GIF="gen_beachdance_compare.gif"
WIDTH=640
ASPECT_RATIO="16:9"
TEMP_DIR="gif_frames"

# --- Step 1: Extract frames using ffmpeg ---
# This step extracts frames and scales them to 640x360 (for 16:9 aspect ratio).
# It uses the high-quality H.264 decoder and outputs to the temporary directory.

mkdir -p "$TEMP_DIR"

ffmpeg -i "$INPUT_FILE" -vf scale=$WIDTH:-1 -r 10 "$TEMP_DIR/frame_%04d.png"

# --- Step 2: Create GIF using ImageMagick 6 ---
# The -loop 0 sets infinite loop. -delay 10 translates to 10 FPS (100ms per frame).

convert -delay 10 -loop 0 "$TEMP_DIR/frame_*.png" "$OUTPUT_GIF"

# --- Step 3: Cleanup ---
rm -rf "$TEMP_DIR"
