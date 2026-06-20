@echo off
echo ========================================================
echo Restaurando suas alteracoes customizadas...
echo ========================================================

echo.
echo Copiando task_watcher.js...
copy /Y "%~dp0pacote_customizado\src\task_watcher.js" "%~dp0src\task_watcher.js"

echo.
echo Copiando pt-br.json...
copy /Y "%~dp0pacote_customizado\locales\pt-br.json" "%~dp0locales\pt-br.json"

echo.
echo Copiando documentacao de arquitetura...
xcopy /Y /E /I "%~dp0pacote_customizado\docs" "%~dp0docs"

echo.
echo ========================================================
echo Restauracao concluida com sucesso!
echo ========================================================
pause
