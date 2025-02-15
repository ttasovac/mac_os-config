# Tide configs

## A

`tide configure --auto --style=Rainbow --prompt_colors='True color' --show_time=No --rainbow_prompt_separators=Angled --powerline_prompt_heads=Sharp --powerline_prompt_tails=Flat --powerline_prompt_style='One line' --prompt_spacing=Compact --icons='Many icons' --transient=No`

Followed by:

```sh
set -a tide_right_prompt_items git
set tide_left_prompt_items pwd
tide reload
```

![alt text](/images/A.png)

## B

`tide configure --auto --style=Lean --prompt_colors='True color' --show_time=No --lean_prompt_height='Two lines' --prompt_connection=Disconnected --prompt_spacing=Sparse --icons='Many icons' --transient=No`

![alt text](/images/B.png)
