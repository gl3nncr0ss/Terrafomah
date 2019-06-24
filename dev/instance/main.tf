/* Requires:  vpc id, vpc name, the VPC module */

/*
  Set up all of the stuff the instances will need
*/

/*
  Web Server
*/

resource "aws_instance" "MindaLive-web" {
    ami = "${var.ami_web}"
    availability_zone = "${var.private_availability_zone}"
    instance_type = "${var.web_server_instance_type}"
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${var.webserver_sg_id}"]
    subnet_id = "${var.private_subnet_id}"
    associate_public_ip_address = true
    source_dest_check = false

    tags {
        Name = "${var.vpc_name}-web"
    }

    /* Set up MindaLive-web */
    user_data = <<EOF
      <script>
        winrm quickconfig -q & winrm set winrm/config @{MaxTimeoutms="1800000"} & winrm set winrm/config/service @{AllowUnencrypted="true"} & winrm set winrm/config/service/auth @{Basic="true"}
      </script>
      <powershell>
        netsh advfirewall firewall add rule name="WinRM in" protocol=TCP dir=in profile=any localport=5985 remoteip=any localip=any action=allow
        # Set Administrator password
        $admin = [adsi]("WinNT://./administrator, user")
        $admin.psbase.invoke("SetPassword", "${var.admin_password}")
      </powershell>
    EOF
}

/*
  Bastion Server
*/

resource "aws_instance" "BastionServer" {
    ami = "${var.ami_bastion}"
    availability_zone = "${var.public_availability_zone}"
    instance_type = "${var.bastion_server_instance_type}"
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${var.bastion_sg_id}"]
    subnet_id = "${var.public_subnet_id}"
    associate_public_ip_address = true
    source_dest_check = false


    tags {
        Name = "${var.vpc_name}-Bastion"
    }

    /* Set up Bastion */
    user_data = <<EOF
      <script>
        winrm quickconfig -q & winrm set winrm/config @{MaxTimeoutms="1800000"} & winrm set winrm/config/service @{AllowUnencrypted="true"} & winrm set winrm/config/service/auth @{Basic="true"}
      </script>
      <powershell>
        netsh advfirewall firewall add rule name="WinRM in" protocol=TCP dir=in profile=any localport=5985 remoteip=any localip=any action=allow
        # Set Administrator password
        $admin = [adsi]("WinNT://./administrator, user")
        $admin.psbase.invoke("SetPassword", "${var.admin_password}")
        New-Item -Path c:\temp -ItemType directory
        (New-Object System.Net.WebClient).DownloadFile("https://s3-ap-southeast-2.amazonaws.com/minda-terraform-state/software/MINDAWeb_DB_for_brad.bak","c:\temp\MINDAWeb_DB.bak")
      </powershell>
    EOF
}

resource "aws_eip" "bastion" {
    instance = "${aws_instance.BastionServer.id}"
    vpc = true

    tags {
        Name = "${var.vpc_name}-Bastion-EIP"
    }
}
