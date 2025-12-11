#!/usr/bin/env bash

SESSION="dashboard"

# Si la sesión ya existe, solo adjuntate
tmux has-session -t "$SESSION" 2>/dev/null
if [ $? -eq 0 ]; then
  tmux attach -t "$SESSION"
  exit 0
fi

# Crear sesión nueva en segundo plano con el primer comando (arriba izquierda)
tmux new-session -d -s "$SESSION" 'btop' # monitor de sistema

# Dividir a la derecha (arriba derecha) para, por ejemplo, ticker de stocks
tmux split-window -h -t "$SESSION":0 'circumflex'

# Volver al pane 0 (arriba izquierda) y dividir abajo para un reproductor de música
tmux select-pane -t "$SESSION":0.0
tmux split-window -v -t "$SESSION":0 'fastfetch'

# Ir al pane de la derecha (arriba derecha) y dividir abajo para un editor/helix
tmux select-pane -t "$SESSION":0.1
tmux split-window -v -t "$SESSION":0 'yazi'

# Opcional: ajustar layout a mosaico
tmux select-layout -t "$SESSION":0 tiled

# Adjuntar a la sesión
tmux attach -t "$SESSION"
