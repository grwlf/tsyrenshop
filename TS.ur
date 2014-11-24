structure B = Bootstrap
structure X = XmlGen
structure P = Prelude
structure CSS = CSS
structure Str = String
structure O = Option

val swap = @@P.swap
val ap = @@P.ap
val fst = @@P.fst
val snd = @@P.snd
val cl = @@CSS.list
val nest = @@X.nest
val lift = @@X.lift
val push_back = @@X.push_back
val push_front = @@X.push_front
val push_back_ = @@X.push_back_
val push_front_ = @@X.push_front_
val push_back_xml = @@X.push_back_xml
val data = data_attr data_kind
val aria = data_attr aria_kind

con cat = [Id = int, CNam = string]

table category : (cat)

con store = [Id = int, Nam = string, Price = string, CId = int]

table store : (store)

fun template (mb:transaction xbody) : transaction page =
  u <- ap show currentUrl;
  let
    Uru.run (
    JQuery.add (
    Bootstrap.add (
    myHeaders (
    Uru.withBody (fn _ =>
      b <- mb;
      return
        <xml>
          <div class={cl (B.navbar :: B.navbar_inverse :: B.navbar_fixed_top :: [])} role="navigation">
            <div class={B.container}>
              <div class={B.navbar_header}>
                <a class={B.navbar_brand} href={url (main {})}>TsyrenShop</a>
              </div>
              <div class={cl (B.collapse :: B.navbar_collapse :: [])}>
                <ul class={cl (B.nav :: B.navbar_nav :: [])}>
                  {active (url (catalog {})) "Каталог"}
                  {active (url (contacts {})) "Контакты"}
                </ul>
              </div>
            </div>
          </div>

          <div class={B.container} style="margin-top:50px; margin-bottom:100px">
          {b}
          </div>

          <div style="padding-top:20px;position:absolute;bottom:0; width:100%; height:100px;">
            <div class={B.container} style="text-align:center">
              <hr/>
              <p class={B.text_muted}>Proudly designed by
                <a href={bless "http://github.com/grwlf"}>@grwlf</a>.
                Powerd by <a href={bless "http://impredicative.com/ur/"}>Ur/Web</a> framework.
              </p>
              <p class={B.text_muted}>
              <ul style="padding-left: 0px; margin-top: 20px; color: #999;">
                {StyleSoup.footer_doc_links (
                <xml><a href={bless "http://github.com/grwlf/tsyrenshop"}>Sources</a></xml> ::
                <xml><a href={bless "http://impredicative.com/ur/"}>Ur/Web</a></xml> ::
                <xml><a href={bless "http://github.com"}>GiHub</a></xml> ::
                []
                )}
              </ul>
              </p>
            </div>
          </div>
        </xml>
      )))))

  where

    fun active (l:url) (t:string) =
      case strsindex (show l) u of
        |None => <xml><li><a href={l}>{[t]}</a></li></xml>
        |Some _ => <xml><li class={B.active}><a href={l}>{[t]}</a></li></xml>

    (* fun myHeaders f r = *) 
    (*   f (swap Uru.addHeader r *)
    (*     <xml> *)
    (*       <title>Tsyren shop</title> *)
    (*     </xml>) *)

    fun myHeaders f r = 
      f (swap Uru.addHeader r
        <xml>
          <title>Compet</title>
          <link rel="stylesheet" href={url (catalog {})}/>
        </xml>)
  end

and contacts {} : transaction page =
  template (
    return <xml></xml>
  )

and catalog {} : transaction page =
  template (
    return <xml></xml>
  )

and main {} : transaction page = redirect(url(catalog {}))

