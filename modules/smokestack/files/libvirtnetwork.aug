module LibvirtNetwork =
   autoload xfm
   let filter = incl "/etc/libvirt/qemu/networks/default.xml"
   let xfm = transform Xml.lns filter
