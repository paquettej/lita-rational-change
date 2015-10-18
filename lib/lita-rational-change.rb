require "lita"

Lita.load_locales Dir[File.expand_path(
  File.join("..", "..", "locales", "*.yml"), __FILE__
)]

require "lita/handlers/rational_change"
require "mention"
require "change_request"

Lita::Handlers::RationalChange.template_root File.expand_path(
  File.join("..", "..", "templates"),
 __FILE__
)
