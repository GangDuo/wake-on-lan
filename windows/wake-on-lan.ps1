class MacAddress {
    [byte[]] $Value;

    MacAddress([string] $value) {
        $this.Value = [byte[]]($value.split("-") | ForEach-Object{[Convert]::ToInt32($_, 16)});
        Write-Verbose ("MacAddress: " + $this.Value);
    }
}

class MagicPacket {
    [byte[]] $Value;

    MagicPacket([MacAddress] $macAddress) {
        $this.Value = ([byte[]](@(0xff) * 6)) + $macAddress.Value * 16;
        Write-Verbose ("MagicPacket: " + $this.Value);
    }

    [void] Broadcast() {
    }
}

$VerbosePreference = "Continue";
$MagicPacket = New-Object MagicPacket((New-Object MacAddress("00-00-00-00-00-00")));
$MagicPacket.Broadcast();
Write-Output "Send MagicPacket.";