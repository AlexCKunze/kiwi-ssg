# Test Code
## Date 11/07/2023

<post>

Test

</post>
<post>
<div class="code">
{code-block}
<pre>
<code>

#!/usr/bin/env bash

i=$(curl -v https://nixos.org/manual/nixos/stable/index.html#sec-upgrading 2>&1 | grep "nix-channel --add" | grep -v unstable | grep -v small | grep -v channel-name  | grep \# | cut -d "/" -f4 | cut -d "-" -f2 | cut -d " " -f1)
sudo nix-channel --add https://channels.nixos.org/nixos-$i nixos
sudo nix-channel --list
read -p "Hit enter to update to the current release, or hit CTRL+C to cancel"
sudo nixos-rebuild switch --upgrade
</code>
</pre>

</div>
</post>
