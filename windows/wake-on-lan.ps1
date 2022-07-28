class MacAddress {
    MacAddress([string] $value) {
    }
}

class MagicPacket {
    MagicPacket([MacAddress] $macAddress) {
    }

    [void] Broadcast() {
    }
}

$MagicPacket = New-Object MagicPacket((New-Object MacAddress("00-00-00-00-00-00")));
$MagicPacket.Broadcast();
Write-Output "Send MagicPacket.";