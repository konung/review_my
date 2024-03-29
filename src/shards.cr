# Load .env file before any other config or app code
require "lucky_env"
LuckyEnv.load?(".env")

# Require your shards here
require "avram"
require "lucky"
require "carbon"
require "carbon_aws_ses_adapter"
require "authentic"
require "jwt"
require "raven"
require "raven/integrations/lucky"
