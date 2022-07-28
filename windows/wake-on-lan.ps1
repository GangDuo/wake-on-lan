class MacAddress {
    [byte[]] $Value;

    MacAddress([string] $value) {
        $this.Value = [byte[]]($value.split("-") | ForEach-Object{[Convert]::ToInt32($_, 16)});
        Write-Verbose ("MacAddress: " + $this.Value);
    }
}

class MagicPacket {
    MagicPacket([MacAddress] $macAddress) {
    }

    [void] Broadcast() {
    }
}

$VerbosePreference = "Continue";
$MagicPacket = New-Object MagicPacket((New-Object MacAddress("00-00-00-00-00-00")));
$MagicPacket.Broadcast();
Write-Output "Send MagicPacket.";