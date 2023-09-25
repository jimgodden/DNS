param privateDNSZoneLinkedVnetNamesList array

param amountOfRecords int

param privateDNSZoneLinkedVnetIDList array

param privateDNSZone_Name string = 'godden.me'


resource privateDNSZone 'Microsoft.Network/privateDnsZones@2018-09-01' = {
  name: privateDNSZone_Name
  location: 'global'
}

resource dnsRecord 'Microsoft.Network/privateDnsZones/A@2020-06-01' = [ for i in range(1, amountOfRecords): {
  parent: privateDNSZone
  name: '${i}'
  properties: {
    ttl: 6
    aRecords: [
      {
        ipv4Address: '10.0.0.1'
      }
    ]
  }

} ]

resource virtualNetworkLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2018-09-01' = [ for i in range(0, length(privateDNSZoneLinkedVnetIDList)): {
  parent: privateDNSZone
  name: '${privateDNSZone.name}_to_${privateDNSZoneLinkedVnetNamesList[i]}'
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: privateDNSZoneLinkedVnetIDList[i]
    }
  }
}]
