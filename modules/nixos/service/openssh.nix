{
  ...
}:
{
  config = {
    services = {
      openssh = {
        enable = true;
        settings = {
          # 豁免回环地址
          PerSourcePenaltyExemptList = "127.0.0.1,::1";
          # 只允许公钥认证
          AuthenticationMethods = "publickey";
        };
      };
    };
  };
}
