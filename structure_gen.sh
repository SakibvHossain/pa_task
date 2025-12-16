#!/usr/bin/env bash
set -euo pipefail

# Root folder
ROOT="lib"

folders=(
  # app layer
  "$ROOT/app/theme"
  "$ROOT/app/flavors"

  # core layer
  "$ROOT/core/constants"
  "$ROOT/core/error"
  "$ROOT/core/network"
  "$ROOT/core/utils"

  # features → repositories
  "$ROOT/features/repositories/data/models"
  "$ROOT/features/repositories/data/datasources"
  "$ROOT/features/repositories/data/repository"

  "$ROOT/features/repositories/domain/entities"
  "$ROOT/features/repositories/domain/repository"
  "$ROOT/features/repositories/domain/usecases"

  "$ROOT/features/repositories/presentation/bloc"
  "$ROOT/features/repositories/presentation/pages"
  "$ROOT/features/repositories/presentation/widgets"
)

for f in "${folders[@]}"; do
  mkdir -p "$f"
  echo "Created $f"
done



# main.dart
cat > "$ROOT/main.dart" <<'EOF'
import 'package:flutter/material.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}
EOF


echo -e "\nFeature-first BLoC folder structure generated successfully!"
