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
        $udpClient = new-object System.Net.Sockets.UdpClient;
        $wakeUpTarget = [System.Net.IPAddress]::Broadcast;
        $udpClient.Connect($wakeUpTarget, 9);
        $udpClient.Send($this.Value, $this.Value.Length) | out-null;
        $udpClient.Close();
    }
}

$VerbosePreference = "Continue";
$MagicPacket = New-Object MagicPacket((New-Object MacAddress("00-00-00-00-00-00")));
$MagicPacket.Broadcast();
Write-Output "Send MagicPacket.";