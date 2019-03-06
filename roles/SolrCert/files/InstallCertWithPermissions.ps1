Param
(
  [String] $certPath,
  [SecureString] $password,
  [System.Security.Cryptography.X509Certificates.StoreName] $storeName,
  [String] $username
)


[Reflection.Assembly]::Load("System.Security, Version=2.0.0.0, Culture=Neutral, PublicKeyToken=b03f5f7f11d50a3a")

# Generate certificate object from certificate file, using correct flags to persist private key
$flags = [System.Security.Cryptography.X509Certificates.X509KeyStorageFlags]::MachineKeySet -bor [System.Security.Cryptography.X509Certificates.X509KeyStorageFlags]::PersistKeySet
$cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2($certPath, $password, $flags)

# Install certificate to store
$store = New-Object System.Security.Cryptography.X509Certificates.X509Store($storeName, [System.Security.Cryptography.X509Certificates.StoreLocation]::LocalMachine)
$store.Open([System.Security.Cryptography.X509Certificates.OpenFlags]::ReadWrite);
$store.Add($cert);
$store.Close();

# Set Read permission for certificate for $username
$keyname=(($cert.PrivateKey).CspKeyContainerInfo).UniqueKeyContainerName
$keypath = $env:ProgramData + "\Microsoft\Crypto\RSA\MachineKeys\"
$fullpath=$keypath+$keyname

$Acl = Get-Acl $fullpath
$Ar = New-Object System.Security.AccessControl.FileSystemAccessRule($username, "Read", "Allow")
$Acl.SetAccessRule($Ar)
Set-Acl $fullpath $Acl
