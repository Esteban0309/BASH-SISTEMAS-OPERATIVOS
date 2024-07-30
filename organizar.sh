#!/bin/bash

documentos_dir="documentos"
video_dir="video"
audio_dir="audio"
imagen_dir="imagen"
otros_dir="otros"

mkdir -p "$documentos_dir" "$video_dir" "$audio_dir" "$imagen_dir" "$otros_dir"

for file in *; do
    if [ -f "$file" ]; then
        archivo=$(basename "$file")
        extension=$(echo "$file" | awk -F"." '{print $2}')

        # Si el archivo no tiene extension, obtener el tipo de archivo usando comando "file"
        if [ -z "$extension" ]; then
            tipo_archivo=$(file -b --mime-type "$file")

            # segun tipo de archivo se agrega la extension y mover a la carpeta correspondiente
            case "$tipo_archivo" in
                application/vnd.openxmlformats-officedocument.spreadsheetml.sheet)
                    mv "$file" "${documentos_dir}/${archivo}.xlsx" ;;
                application/vnd.openxmlformats-officedocument.wordprocessingml.document)
                    mv "$file" "${documentos_dir}/${archivo}.docx" ;;
                application/vnd.openxmlformats-officedocument.presentationml.presentation)
                    mv "$file" "${documentos_dir}/${archivo}.pptx" ;;
                application/pdf)
                    mv "$file" "${documentos_dir}/${archivo}.pdf" ;;
                audio/mpeg)
                    mv "$file" "${audio_dir}/${archivo}.mp3" ;;
                video/mp4)
                    mv "$file" "${video_dir}/${archivo}.mp4" ;;
                image/jpeg)
                    mv "$file" "${imagen_dir}/${archivo}.jpeg" ;;
                image/jpg)
                    mv "$file" "${imagen_dir}/${archivo}.jpg" ;;
                image/png)
                    mv "$file" "${imagen_dir}/${archivo}.png" ;;
                image/gif)
                    mv "$file" "${imagen_dir}/${archivo}.gif" ;;
                *)
                    mv "$file" "${otros_dir}/${archivo}" ;;
            esac
        else
            # Si el archivo tiene una extension conocida, mover a la carpeta correspondiente
            case "$extension" in
                xlsx)  mv "$file" "$documentos_dir/$archivo" ;;
                docx)  mv "$file" "$documentos_dir/$archivo" ;;
                pptx)  mv "$file" "$documentos_dir/$archivo" ;;
                pdf)   mv "$file" "$documentos_dir/$archivo" ;;
                mp3)   mv "$file" "$audio_dir/$archivo" ;;
                mp4)   mv "$file" "$video_dir/$archivo" ;;
                jpeg)  mv "$file" "$imagen_dir/$archivo" ;;
                jpg)     mv "$file" "$imagen_dir/$archivo" ;;
                png)   mv "$file" "$imagen_dir/$archivo" ;;
                gif)   mv "$file" "$imagen_dir/$archivo" ;;
                *)     mv "$file" "$otros_dir/$archivo" ;;
            esac
        fi
    fi
done

