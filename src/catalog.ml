type family_group = ClassicSix | ModernCore | LaterFallback
type t = { name : string; group : family_group; parity_class : string }

let repo = "ocaml-stakeholder"

let classic_six =
  [
    { name = "code_analyzer"; group = ClassicSix; parity_class = "dedicated" };
    { name = "data_processing"; group = ClassicSix; parity_class = "dedicated" };
    { name = "jargon"; group = ClassicSix; parity_class = "dedicated" };
    { name = "metrics"; group = ClassicSix; parity_class = "dedicated" };
    {
      name = "network_activity";
      group = ClassicSix;
      parity_class = "dedicated";
    };
    {
      name = "system_monitoring";
      group = ClassicSix;
      parity_class = "dedicated";
    };
  ]

let modern_core =
  [
    { name = "agent_workflows"; group = ModernCore; parity_class = "dedicated" };
    {
      name = "platform_engineering";
      group = ModernCore;
      parity_class = "dedicated";
    };
    {
      name = "observability_ai_runtime";
      group = ModernCore;
      parity_class = "dedicated";
    };
    {
      name = "delivery_preview_ops";
      group = ModernCore;
      parity_class = "dedicated";
    };
    {
      name = "supply_chain_security";
      group = ModernCore;
      parity_class = "dedicated";
    };
  ]

let later_fallback =
  [
    {
      name = "ai_governance";
      group = LaterFallback;
      parity_class = "grouped-fallback";
    };
    {
      name = "security_blockchain";
      group = LaterFallback;
      parity_class = "grouped-fallback";
    };
    {
      name = "health_protocol";
      group = LaterFallback;
      parity_class = "grouped-fallback";
    };
    {
      name = "overlay_quantum";
      group = LaterFallback;
      parity_class = "grouped-fallback";
    };
  ]

let all = classic_six @ modern_core @ later_fallback

let group_name = function
  | ClassicSix -> "classic-six"
  | ModernCore -> "modern-core"
  | LaterFallback -> "later-fallback"

let group_label = function
  | ClassicSix -> "dedicated classic-six"
  | ModernCore -> "dedicated modern-core"
  | LaterFallback -> "grouped fallback"

let families_for_group = function
  | "classic-six" -> Some classic_six
  | "modern-core" -> Some modern_core
  | "later-fallback" -> Some later_fallback
  | _ -> None

let find_family name =
  List.find_opt (fun family -> String.equal family.name name) all
