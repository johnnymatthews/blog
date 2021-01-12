---
title: Edit multiple lines in Vim on Windows
description: How to edit multiple lines at once, using Vim in Windows. Specifically, I'm using Powershell.
---

# Edit multiple lines in Vim

Say we've got the following code and we want to move everything between the `<table>` tags over by a tab:

```html
<div>
<table>
    <thead>
        <tr>
            <th>One</th>
            <th>Two</th>
            <th>Three</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Apple</td>
            <td>Banana</td>
            <td>Carrot</td>
        </tr>
    </tbody>
<table>
</div>
```

1. Move the cursor to the `<` in `<table>`.
1. Press `CTRL` + `v` to enter `visual-block` mode. In Windows this defaults to `CTRL` + `q`.
1. Move to the line with `</table>`, either by pressing `j` multiple times, or entering `15j`.
1. Press `I`. Make sure to use a capital `i`.
1. Press tab to move the lines over. Only the top `<table>` line will move right now.
1. Press `ESC`. All the other lines should move over now.

If you would rather add a change to each line _after_ the selected character, use `A` instead of `I`.
