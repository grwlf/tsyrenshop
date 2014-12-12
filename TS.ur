structure B = Bootstrap
structure X = XmlGen
structure P = Prelude
structure CSS = CSS
structure Str = String
structure O = Option
structure U = UTF8

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


val nav = @@NavTag.nav

(*

 ____        _       _____                      
|  _ \  __ _| |_ __ |_   _|   _ _ __   ___  ___ 
| | | |/ _` | __/ _` || || | | | '_ \ / _ \/ __|
| |_| | (_| | || (_| || || |_| | |_) |  __/\__ \
|____/ \__,_|\__\__,_||_| \__, | .__/ \___||___/
                          |___/|_|              

*)

con cat = [Id = int, ParentId = int, CNam = string]

table category : (cat)
  PRIMARY KEY Id

con store = [Id = int, Nam = string, Price = string, CId = int]

table store : (store)
  PRIMARY KEY Id


(*
 _   _ _   _ _ 
| | | | |_(_) |
| | | | __| | |
| |_| | |_| | |
 \___/ \__|_|_|

*)

fun fstcap s = (U.str (U.toUpper (U.at s 0))) ^ (U.mp U.toLower (U.tail s))

fun tnest [a ::: Type] (nb : X.state xtable a) : X.state xbody (xbody * a) =
  nest (fn x =>
    <xml>
      <table class={cl (B.bs3_table :: B.table_striped :: [])}>
        {x}
      </table>
    </xml>) nb

fun rownest [a ::: Type] (nb : X.state xbody a) : X.state xbody (xbody * a) =
  nest (fn x =>
    <xml>
      <div class={cl (B.row :: [])}>
        {x}
      </div>
    </xml>) nb

fun xnest f m = push_back (nest f m)

fun template_ t (mb:transaction xbody) : transaction page =
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
          <div class={B.container} style="margin-top:50px; margin-bottom:100px; max-width:730px">

            <div style="border-bottom:1px solid #e5e5e5; margin-bottom:30px; padding-bottom:19px">
              <nav>
                <ul class={cl (B.nav :: B.nav_pills :: B.pull_right :: [])}>
                  {List.mapX (fn x => active x.Url x.Text) t.Menu}
                </ul>
              </nav>
              <h3 class={B.text_muted}>Project name</h3>
            </div>

            <div class={B.jumbotron} style="text-align:center">
              <h1>Jumbotron heading</h1>
              <p class={B.lead}>Cras justo odio, dapibus ac facilisis
              in, egestas eget quam. Fusce dapibus, tellus ac
              cursus commodo, tortor mauris condimentum nibh, ut
              fermentum massa justo sit amet risus.</p>
              <p><a class={cl (B.btn :: B.btn_lg :: B.btn_success :: [])} href={url(main {})} role="button"
                  style="font-size:21px">
                Sign up today
              </a></p>
            </div>

            {b}
          </div>

          <div style="position:relative; min-height: 100%;">
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
                  <xml><a href={links.Admin}>Admin</a></xml> ::
                  []
                  )}
                </ul>
                </p>
              </div>
            </div>
          </div>
        </xml>
      )))))

  where

    val links = {
      Main = url (main {}),
      Cat = url (catalog {}),
      Contacts = url (contacts {}),
      Admin = url (admin {})
     }

    fun active (l:url) (t:string) =
      case strsindex (show l) u of
        |None => <xml><li><a href={l}>{[t]}</a></li></xml>
        |Some _ => <xml><li class={B.active}><a href={l}>{[t]}</a></li></xml>

    fun myHeaders f r = 
      f (swap Uru.addHeader r
        <xml>
          <title>Tsyren shop</title>
          <link rel="stylesheet" href={TS_css.geturl}/>
        </xml>)
  end

and template x = let template_ a x where
    val a = {
      Menu =  { Text = "Каталог", Url = url (catalog_cat {}) }
           :: { Text = "Контакты", Url = url (main {}) }
           :: []
      }
  end

(*
 __  __       _       
|  \/  | __ _(_)_ __  
| |\/| |/ _` | | '_ \ 
| |  | | (_| | | | | |
|_|  |_|\__,_|_|_| |_|
                      
*)

and admin {} : transaction page =
  template (
    return <xml></xml>
  )

and contacts {} : transaction page =
  template (
    return <xml></xml>
  )

and catalog_cat {} : transaction page =
  template ( X.run (

    xnest (fn x=><xml><div class={B.row}>{x}</div></xml>) (

      X.query_
      (SELECT * FROM category AS C1 WHERE C1.ParentId=-1)
      (fn c1 =>

        xnest (fn x=><xml><div class={cl (B.col_lg_4 :: B.col_xs_6 :: [])}>{x}</div></xml>) (

          push_back_xml
          <xml><h3>{[fstcap c1.C1.CNam]}</h3></xml>;

          X.query_
          (SELECT * FROM category AS C WHERE C.ParentId={[c1.C1.Id]})
          (fn c2 =>
            push_back_xml (StyleSoup.badge (fstcap c2.C.CNam) 33)
          );

          return {}
        )
      );

      return {}
    )
  ))

and catalog {} : transaction page =
  template ( X.run (
    push_back_xml
    <xml><h1>catalog</h1></xml>;

    push_back ( tnest (
      push_back_xml
      <xml><tr>
        <th>Id</th>
        <th>CId</th>
        <th>Name</th>
        <th>Price</th>
      </tr></xml>;

      X.query_
      (SELECT * FROM store AS S)
      (fn fs =>
        push_back_xml
        <xml><tr>
          <td>{[fs.S.Id]}</td>
          <td>{[fs.S.CId]}</td>
          <td>{[fs.S.Nam]}</td>
          <td>{[fs.S.Price]}</td>
        </tr></xml>
      );
      return {}
    ));

    return {}
  ))

and main {} : transaction page = redirect(url(catalog_cat {}))

