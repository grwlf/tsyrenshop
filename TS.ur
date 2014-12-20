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
      ss <- source "";
      return
        <xml>
          <div class={B.container} style="margin-top:50px; margin-bottom:100px; max-width:730px">

            <div style="border-bottom:1px solid #e5e5e5; margin-bottom:30px; padding-bottom:19px">

              <div class={B.row}>
                <div class={B.col_md_12}>
                (* <nav> *)
                  <ul class={cl (B.nav :: B.nav_pills :: B.pull_right :: [])}>
                    {List.mapX (fn x => active x.Url x.Text) t.Menu}
                  </ul>
                  <h1 style="padding-bottom:19px;margin-top:0;margin-bottom:0;line-height:40px;" class={B.text_muted}>
                    Магазин
                  </h1>
                (* </nav> *)
                </div>
              </div>

            </div>

            <div class={B.row} style="margin-bottom:30px"><div class={B.col_md_12}>

              <form class={cl (B.form_inline :: B.pull_right :: [])} role="search">
                <div class={B.input_group}>
                  <ctextbox source={ss} class={cl (B.form_control::B.input_sm::[])} placeholder="Поиск"/>
                  <span class={B.input_group_btn}>
                    <button class={CSS.list (B.btn ::B.input_sm :: B.btn_default :: [])} onclick={fn _ =>
                      s <- get ss; redirect(url(search s))
                    }>
                      <span class={cl (B.glyphicon :: B.glyphicon_search :: [])}></span>&nbsp;
                    </button>
                  </span>
                </div>
                <submit style="display:none" action={handler}/>
              </form>

            </div></div>

            {if t.Jumbotron then
            <xml>
            <div class={B.jumbotron} style="text-align:center">
              <h1>Реклама</h1>
              <p class={B.lead}>Cras justo odio, dapibus ac facilisis
              in, egestas eget quam. Fusce dapibus, tellus ac
              cursus commodo, tortor mauris condimentum nibh, ut
              fermentum massa justo sit amet risus.</p>
              <p><a class={cl (B.btn :: B.btn_lg :: B.btn_success :: [])} href={url(main {})} role="button"
                  style="font-size:21px">
                Sign up today
              </a></p>
            </div>
            </xml>
            else <xml/>}

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
      Cat = url (catalog_cat {}),
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

     fun handler (f:{}) =
       redirect (url(main {}))
  end

and template_m t x = let template_ (t ++ a) x where
    val a = {
      Menu =  { Text = "Каталог", Url = url (catalog_cat {}) }
           :: { Text = "Контакты", Url = url (main {}) }
           :: []
      }
  end

and template_top x = template_m { Jumbotron = True } x
and template x = template_m { Jumbotron = False } x

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
  template_top ( X.run (

    xnest (fn x=><xml><div class={B.row}>{x}</div></xml>) (

      (* FIXME: What about -1 parent id? *)
      X.query_
      (SELECT C1.CNam, C1.Id, S.N FROM

      category AS C1,
      
      (SELECT C.ParentId AS P, COUNT( * ) AS N
       FROM category AS C
       WHERE C.ParentId > 0
       GROUP BY C.ParentId) AS S

      WHERE S.P = C1.Id
      ORDER BY S.N DESC
      )
      (fn c1 =>

        xnest (fn x=><xml><div class={cl (B.col_lg_4 :: B.col_xs_6 :: [])}>{x}</div></xml>) (

          push_back_xml
          <xml><h3>{[fstcap c1.C1.CNam]}</h3></xml>;

          X.query_
          (SELECT C.Id, C.CNam, G.N
           FROM category AS C,

           (SELECT S.CId AS CId, COUNT( * ) AS N
            FROM store AS S
            GROUP BY S.CId) AS G
           
           WHERE C.ParentId={[c1.C1.Id]} AND G.CId = C.Id AND G.N > 0
           ORDER BY C.CNam
          )
          (fn c2 =>
            push_back_xml
            <xml><a href={url(catalog c2.C.Id)}>{[fstcap c2.C.CNam]} ({[c2.G.N]})</a><br/></xml>;
            return {}
          );

          return {}
        )
      );

      return {}
    )
  ))

and catalog cid : transaction page =
  template ( X.run (

    (* FIXME: What about -1 parent id? *)
    n <- lift (oneRow (SELECT C2.CNam, C.CNam, C.Id
      FROM category AS C,
           category AS C2
      WHERE C.Id = {[cid]} AND
            C.ParentId = C2.Id));

    push_back_xml
    <xml>
    <ol class={B.breadcrumb}>
      <li><a href={url(catalog_cat {})}>Главная</a></li>
      <li><a href={url(catalog_cat {})}>{[fstcap n.C2.CNam]}</a></li>
    </ol>
    <h1>{[fstcap n.C.CNam]}</h1>
    </xml>;

    push_back ( tnest (
      push_back_xml
      <xml><tr>
        <th>Название</th>
        <th>Цена</th>
      </tr></xml>;

      X.query_
      (SELECT * FROM store AS S WHERE S.CId = {[cid]}
       ORDER BY S.Nam)
      (fn fs =>
        push_back_xml
        <xml><tr>
          <td>{[fs.S.Nam]}</td>
          <td>{[fs.S.Price]}</td>
        </tr></xml>
      );
      return {}
    ));

    return {}
  ))

and search (q:string) : transaction page =
  template ( X.run (
    push_back_xml
    <xml>
      <h1>Search result for {[q]}</h1>
    </xml>;
    return {}
  ))


and main {} : transaction page = redirect(url(catalog_cat {}))

