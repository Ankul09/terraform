resource "aws_vpc" "myvpc-terra" {
    cidr_block = "10.0.0.0/16"
  
}

resource "aws_subnet" "sub1" {
  vpc_id = aws_vpc.myvpc-terra.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone = "ap-southeast-2a"
}

resource "aws_subnet" "sub2" {
  vpc_id = aws_vpc.myvpc-terra.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-southeast-2b"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
vpc_id=aws_vpc.myvpc-terra.id 
}



resource "aws_route_table" "rt" {
vpc_id= aws_vpc.myvpc-terra.id

route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
       }

}

resource "aws_route_table_association" "rta1" {
subnet_id =   aws_subnet.sub1.id
route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "rta2" {
subnet_id =   aws_subnet.sub2.id
route_table_id = aws_route_table.rt.id
}