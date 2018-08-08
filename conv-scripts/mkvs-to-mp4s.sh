for i in 13 14 15 16 17 18; do
    ffmpeg -i inbox/my_video-${i}.mkv -c:v libx264 -c:a aac -movflags faststart my_video-${i}.mp4
done

