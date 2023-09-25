@description('Azure Datacenter location for the source resources')
param location string = resourceGroup().location

@description('Username for the admin account of the Virtual Machines')
param vm_adminUsername string

@description('Password for the admin account of the Virtual Machines')
@secure()
param vm_adminPassword string

@description('Size of the Virtual Machines')
param vmSize string = 'Standard_E4as_v4' // 'Standard_D2s_v3' // 'Standard_D16lds_v5'

@description('''True enables Accelerated Networking and False disabled it.  
Not all VM sizes support Accel Net (i.e. Standard_B2ms).  
I'd recommend Standard_D2s_v3 for a cheap VM that supports Accel Net.
''')
param accelNet bool = true

@description('Amount of Windows Virtual Machines to deploy in the source side.  This number is irrelevant if not deploying Windows Virtual Machines')
param amountOfSourceSideWindowsVMs int = 1

@description('Amount of Windows Virtual Machines to deploy in the destination side.  This number is irrelevant if not deploying Windows Virtual Machines')
param amountOfDestinationSideWindowsVMs int = 1

@description('Amount of Linux Virtual Machines to deploy in the source side.  This number is irrelevant if not deploying Linux Virtual Machines')
param amountOfSourceSideLinuxVMs  int = 0

@description('Amount of Linux Virtual Machines to deploy in the destination side.  This number is irrelevant if not deploying Linux Virtual Machines')
param amountOfDestinationSideLinuxVMs  int = 0

// Virtual Networks
module sourceVNET './Modules/VirtualNetwork.bicep' = {
  name: 'srcVNET'
  params: {
    defaultNSG_Name: 'srcNSG'
    firstTwoOctetsOfVNETPrefix: '10.0'
    location: location
    routeTable_Name: 'srcRT'
    vnet_Name: 'srcVNET'
  }
}

module destinationVNET './Modules/VirtualNetwork.bicep' = {
  name: 'dstVNET'
  params: {
    defaultNSG_Name: 'dstNSG'
    firstTwoOctetsOfVNETPrefix: '10.1'
    location: location
    routeTable_Name: 'dstRT'
    vnet_Name: 'dstVNET'
  }
}

// Virtual Network Peerings
module sourceVNETPeering './Modules/VirtualNetworkPeering.bicep' = {
  name: 'srctodstPeering'
  params: {
    dstVNET_Name: destinationVNET.outputs.vnetName
    originVNET_Name: sourceVNET.outputs.vnetName
  }
  dependsOn: [
    sourceBastion
  ]
}

module destinationVNETPeering './Modules/VirtualNetworkPeering.bicep' = {
  name: 'dsttosrcPeering'
  params: {
    dstVNET_Name: sourceVNET.outputs.vnetName
    originVNET_Name: destinationVNET.outputs.vnetName
  }
  dependsOn: [
    sourceBastion
  ]
}

// Windows Virtual Machines
module sourceVM_Windows './Modules/NetTestVM.bicep' = [ for i in range(1, amountOfSourceSideWindowsVMs):  {
  name: 'srcVMWindows${i}'
  params: {
    accelNet: accelNet
    location: location
    nic_Name: 'WindowsClient_NIC${i}'
    subnetID: sourceVNET.outputs.generalSubnetID
    vm_AdminPassword: vm_adminPassword
    vm_AdminUserName: vm_adminUsername
    vm_Name: 'WindowsClient${i}'
    vmSize: vmSize
  }
} ]

module destinationVM_Windows './Modules/NetTestVM.bicep' = [ for i in range(1, amountOfDestinationSideWindowsVMs):  {
  name: 'dstVMWindows${i}'
  params: {
    accelNet: accelNet
    location: location
    nic_Name: 'WindowsServer_NIC${i}'
    subnetID: destinationVNET.outputs.generalSubnetID
    vm_AdminPassword: vm_adminPassword
    vm_AdminUserName: vm_adminUsername
    vm_Name: 'WindowsServer${i}'
    vmSize: vmSize
  }
} ]

// Linux Virtual Machines
module sourceVM_Linx 'Modules/LinuxNetTestVM.bicep' = [ for i in range(1, amountOfSourceSideLinuxVMs):  {
  name: 'srcVMLinux${i}'
  params: {
    accelNet: accelNet
    location: location
    nic_Name: 'LinuxClient_NIC${i}'
    subnetID: sourceVNET.outputs.generalSubnetID
    vm_AdminPassword: vm_adminPassword
    vm_AdminUserName: vm_adminUsername
    vm_Name: 'LinuxClient${i}'
    vmSize: vmSize
  }
} ]

module destinationVMLinx 'Modules/LinuxNetTestVM.bicep' = [ for i in range(1, amountOfDestinationSideLinuxVMs):  {
  name: 'dstVMLinux${i}'
  params: {
    accelNet: accelNet
    location: location
    nic_Name: 'LinuxServer_NIC${i}'
    subnetID: destinationVNET.outputs.generalSubnetID
    vm_AdminPassword: vm_adminPassword
    vm_AdminUserName: vm_adminUsername
    vm_Name: 'LinuxServer${i}'
    vmSize: vmSize
  }
} ]

// Azure Bastion for connecting to the Virtual Machines
module sourceBastion './Modules/Bastion.bicep' = {
  name: 'srcBastion'
  params: {
    bastionSubnetID: sourceVNET.outputs.bastionSubnetID
    location: location
  }
}

module pdz 'Modules/PrivateDNSZone.bicep' = {
  name: 'pdz'
  params: {
    amountOfRecords: 100
    privateDNSZoneLinkedVnetIDList: [destinationVNET.outputs.vnetID]
    privateDNSZoneLinkedVnetNamesList: [destinationVNET.outputs.vnetName]
  }
}
