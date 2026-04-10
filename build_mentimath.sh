#!/bin/bash
#chmod +x build_mentimath.sh
# ./build_mentimath.sh

Run
cd /home/popnoart/WORK/REPOSITORY/FANDOMS/MentiMath

echo "🧮 Generando MentiMath con diseño ORIGINAL..."
echo "============================================"

# Limpiar TODO
rm -rf build/
/opt/flutter/bin/flutter clean

# Generar APK
/opt/flutter/bin/flutter pub get
/opt/flutter/bin/flutter build apk --release

# Probar web
/opt/flutter/bin/flutter build web --release
#cd build/web
#python3 -m http.server 8080 &
echo "🌐 Web: http://localhost:8080"

# Renombrar
cd build/app/outputs/flutter-apk
FECHA=$(date +"%Y%m%d")
cp app-release.apk "MentiMath_${FECHA}.apk"

echo ""
echo "✅ ✅ ✅ APK LISTO ✅ ✅ ✅"
echo "=========================="
echo "📱 Archivo: MentiMath_${FECHA}.apk"
echo "📏 Tamaño: $(du -h MentiMath_${FECHA}.apk | cut -f1)"
echo "📁 Ruta: $(pwd)/MentiMath_${FECHA}.apk"
echo ""
echo "📤 Para copiar al móvil:"
echo "   cp '$(pwd)/MentiMath_${FECHA}.apk' /ruta/a/tu/movil/"
