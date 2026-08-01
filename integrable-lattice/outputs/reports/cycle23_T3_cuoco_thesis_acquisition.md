# cycle 23 / T3 Pure: Cuoco の学位論文（Brandeis, 1979）の入手可否と、定理 W4・(K3) の既出性の決着

対象: cycle 23 step 3（`cuoco_thesis_acquisition`）。
根拠 report: `cycle22_T3_cuoco_monsky_attribution.md`（§1 取得手順・§3 Monsky Lemma 2.3・§4 既出性判定）、
`cycle21_T3_drop_assumption_B_star.md` §11・§13、`cycle20_T3_s_infinity_decision.md`（定理 W3・W4）、
`cycle16_T1_monsky_primary_sources.md`（cycle 16 の原文取得の記録）。

**本 step は本文（`structured-latex/`・`structured-latex-en/`）と検査道具を一切触っていない。成果物はこの report だけである。**

## 0. 結論（先に置く）

| 項目 | 結果 |
|---|---|
| **学位論文の書誌の同定** | **完全に同定した。** A. Cuoco, *Some contributions to the theory of $\mathbb{Z}_p^2$-extensions*, Ph.D. thesis, Brandeis University, 1979。**v, 93 leaves**、Bibliography は leaf 93。UMI/ProQuest 出版番号 **8013627**、ProQuest docview **288025998**、ISBN 9781083253880、OCLC **10088994**。Brandeis 図書館の所蔵は UMI による 1980 年のフォトコピー版（マイクロフィルムは University Archives）。 |
| **本文の入手** | **できなかった。** 無料経路は全滅（§2 に試した URL と応答をすべて記録）。**唯一の実在経路は ProQuest の有料購入か、所蔵館経由の ILL である。どちらもユーザーの判断・資格を要するので実行していない。** |
| **定理 W4 と (K3) の既出性** | **決着した。学位論文を読まずに決着できた。** 決め手は **Monsky, *Some invariants of $\mathbb{Z}_p^d$-extensions* (1981) の Introduction と References を直読したこと**。同論文は **「$l_0$ を導入するのは自分（Monsky）である」と一人称で書き、参考文献に Cuoco の学位論文を 1 件も挙げていない**（§3）。**したがって $l_0$ に関する主張である定理 W4 と (K3) は、1979 年の学位論文には存在しえない。** |
| **step の前提の誤り 1（呼び出し元の指示）** | 指示は「CM が **p.248** で $m_0$・$l_0$ の**詳細**についてそこ（学位論文）を指している」としていたが、**一次情報は違う。** 当該文は **p.252（第 5 章の末尾）** にあり、**学位論文 [1] は「originally introduced（最初に導入した）」の側にしか挙がっていない。「詳細（further information）」の参照先は [2]（Cuoco 1980）と [5]（Monsky 1981）で、どちらも本 step で全文または該当部を読める状態にある。** |
| **step の前提の誤り 2（cycle 22 report）** | `cycle22_T3_cuoco_monsky_attribution.md` §4 は同じ文を「§5 末尾（**p.248**）」としているが、**p.248 は第 5 章の冒頭**であり、当該文は **p.252** にある（両ページの原画像を直読して確認）。**ページ番号の誤記である。** 引用内容そのものは正しい。 |
| **Cuoco 1980 の未読範囲の確認** | **全文（pp.415–437）を通読した。** (K3)・W4 に該当するものは**無い**。同論文が精密に記述する不変量は **$m_0$ だけ**で、$n$ の係数 $m_1$ は**定義されるだけで最後まで一度も特徴づけられない**（§4）。 |

**新規性は一切主張しない。** 本 step がやったのは、書誌を一次情報で同定し、入手経路を実際に試し、
既出性を原論文の帰属記述から決着させ、前提の誤りを 2 件特定したことだけである。

---

## 1. 学位論文の書誌を一次情報で確定した

cycle 22 は表題を知らないまま「Cuoco, Brandeis Ph.D. thesis (1979)」とだけ書いていた。まず表題を取った。

**経路 A（原論文の References）**: Cuoco–Monsky (1981) の References（**p.258 の原ページ画像を直読**）:

> 1. Cuoco, A.: *Some contributions to the theory of $Z_p^2$-extensions*. Brandeis University thesis (1979)
> 2. Cuoco, A.: *The growth of Iwasawa's invariants in a family*. Compositio Math. **41**, 415–437 (1980)

**経路 B（Brandeis 図書館の目録）**: Brandeis の Primo（Ex Libris）の公開 API を叩いて所蔵レコードを取得した。

```bash
curl -H 'Accept: application/json' \
 "https://brandeis.primo.exlibrisgroup.com/primaws/rest/pub/pnxs?inst=01BRAND_INST&lang=en&limit=20&offset=0&\
q=any,contains,Cuoco%20contributions%20theory%20extensions&scope=MyInst_and_CI&tab=Everything&vid=01BRAND_INST:BRAND"
```

ヒットは **2 件**で、どちらも同一の学位論文である。

| | レコード A（Brandeis の所蔵。Alma/MARC21） | レコード B（ProQuest の索引） |
|---|---|---|
| 表題 | Some contributions to the theory of $\mathbb{Z}^2_p$-extensions | SOME CONTRIBUTIONS TO THE THEORY OF Z(P)-SQUARE-EXTENSIONS |
| 著者 | Cuoco, Albert. | CUOCO, ALBERT ANTHONY |
| 年 | **1979** | **1980** |
| 形態 | **v, 93 leaves**／Bibliography: leaf 93 | — |
| 注記 | "UMI:8013627."／"Photocopy. Ann Arbor, Mich.: University Microfilms International, 1980. 22 cm."／"MICROFILM COPY ALSO AVAILABLE IN THE UNIVERSITY ARCHIVES."／"Committed to retain." | ProQuest Dissertations & Theses Global |
| 識別子 | OCLC **(OCoLC)10088994**／Alma MMS 993265810101921 | docview **288025998**／出版番号 **8013627**／ISBN 9781083253880 |
| 主題 | Galois theory / Number theory | Mathematics |
| 提供 | 現物（冊子・マイクロフィルム）。オンライン提供なし | `linktorsrc` → proquest.com（要機関認証） |

**年の食い違い（1979 と 1980）は誤りではない。** 学位授与が 1979 年、UMI がフィルム化・製本したのが
1980 年である（Brandeis のレコードが "Photocopy. Ann Arbor … 1980" と明記している）。
**本文で引用するときは学位授与年 1979 を採る**（CM の References もそうしている）。

**分量が分かったこと自体が判断材料である。** 93 leaves の学位論文に対し、そこから出版された
Cuoco 1980 は 23 ページである。同論文は自ら「The proof of this result forms part of my Brandeis Ph.D. thesis」
（p.416。**this result = Theorem 1.1**）と書いており、**学位論文 ⊋ Cuoco 1980** である。
差分に何があるかは読むまで分からない——ただし §3 の議論により、**その差分に $l_0$ は入りえない。**

---

## 2. 入手のために実際に試した経路（全部書く。「無い」と書く前に確認した）

**壁時計**: 本節の全試行を合わせて 1 分未満。**20 分の設計上限に対して分割は不要だった。**
負荷の判断は不要（ネットワーク I/O のみ、CPU を使っていない）。

| # | 経路 | 実際に叩いた URL / コマンド | 応答（一次情報） | 判定 |
|---|---|---|---|---|
| 1 | **ProQuest 本体** | `https://www.proquest.com/docview/288025998` | HTTP 200。本文は **"Document Preview" / "This is a short preview of the document. Your library or institution may give you access to the complete full text for this document in ProQuest." / "Alternatively, you can purchase a copy of the complete full text for this document directly from ProQuest using the option below: Order a copy"**。実体のテキストは**表題・著者・大学・年・出版番号 8013627 だけ**。 | **不可（要機関認証 or 有料）** |
| 2 | **ProQuest 注文フロー** | `https://order.proquest.com/OA_HTML/pqdtibeCCtpItmDspRte.jsp?sitex=10020:22372:US&item=8013627&dlnow=1&track=1SRCH` | **ログイン画面へリダイレクト**（`pqdtibeCAcdLogin.jsp`）。"Checkout as a guest" はあるが、**価格はチェックアウトへ進まないと表示されない**。 | **有料。購入していない**（不可逆・課金のためユーザー許可が必要） |
| 3 | **ProQuest の抄録** | 同 1 の索引レコード | 抄録として登録されているのは **1 文だけ**——"Approximately twenty years ago, Iwasawa initiated the study of $\mathbb{Z}_p$-extensions."。**これは Cuoco 1980 の冒頭 1 文と完全に同一**であり、内容の手がかりにならない。 | **情報なし** |
| 4 | **Brandeis 機関リポジトリ** | `https://scholarworks.brandeis.edu/search?query=Cuoco` | **HTTP 404**（当該パスは存在しない）。Primo（経路 5）が Brandeis の正規の目録である。 | 不可 |
| 5 | **Brandeis 目録（Primo 公開 API）** | §1 の curl | **HTTP 200、2 件ヒット。**所蔵は**現物のみ**（`delivery` が空。オンライン全文リンクなし）。 | 書誌は取れた／**本文は不可** |
| 6 | **WorldCat** | `https://search.worldcat.org/title/10088994` | HTTP 200。`openAccessLinks: []`、`totalEditions: 1`、`abstract: null`。所蔵館一覧はサーバ側 HTML に含まれず、`/api/search-item-holdings` は **"Oops, something went wrong"**（要トークン）。 | **無料全文なし** |
| 7 | **HathiTrust** | `https://catalog.hathitrust.org/api/volumes/brief/oclc/10088994.json` | `{"records": {}, "items": []}` = **収録なし**。（Web 検索 UI は Cloudflare チャレンジで到達不能） | 収録なし |
| 8 | **Internet Archive** | `https://archive.org/advancedsearch.php?q=Cuoco+Brandeis+extensions&output=json` | `"numFound": 0` | 収録なし |
| 9 | **Open Library** | `https://openlibrary.org/search.json?q=...Cuoco` | `numFound: 0` | 収録なし |
| 10 | **zbMATH Open** | `https://api.zbmath.org/v1/document/_search?search_string=au:"Cuoco"` | 20 件返るが、**A. A. Cuoco の数学の項目は Compositio 1980 と Math. Ann. 1981 の 2 件だけ**（残りは同姓の経済学者 D. Cuoco と、数学教育者としての Al Cuoco の著作）。**学位論文のレコードは無い。** | 収録なし |
| 11 | **Web 検索**（3 クエリ） | 表題・著者・年・"ProQuest" の組み合わせ | 学位論文の**全文へのリンクは 1 件も出ない**。表題を確認できただけ。 | 無料公開なし |
| 12 | **Cuoco 1980（Compositio）** | `https://www.numdam.org/item/CM_1980__41_3_415_0.pdf` | **HTTP 200、1,887,568 bytes。取得成功**。`pdftotext -layout` で全文可読（1,615 行）。 | **成功**（§4） |

### 2.1 越えられなかった壁と、ユーザーが取れる手段

**越えられない理由**（自分では原理的に実行できないもの）:

1. **ProQuest の全文は機関購読の背後にある。** アクセスは OpenAthens 等の**機関認証**（Brandeis の
   リンクは `go.openathens.net/redirector/brandeis.edu?...`）を通る。**私はどの機関の資格情報も持たない。**
2. **購入は課金であり不可逆**である。グローバル方針上、**明示許可のない課金はしてはならない。**
   価格はチェックアウトへ進まないと表示されないため、**金額も確認していない**（憶測の金額は書かない）。

**ユーザーが取れる手段**（具体的に、優先順に）:

1. **ProQuest から直接購入する。** 注文ページは
   `https://order.proquest.com/OA_HTML/pqdtibeCCtpItmDspRte.jsp?item=8013627&sitex=10020:22372:US`。
   **item 番号 8013627 が学位論文の一意な識別子**である。ゲストとしてチェックアウトできる。
   価格はそこで表示される。**購入の可否と金額の判断はユーザーのものなので、私は進めていない。**
2. **所属機関（大学・研究機関）の図書館経由で ProQuest Dissertations & Theses Global にアクセスする。**
   購読していれば追加課金なしに PDF が落ちる。docview 番号 **288025998** で直接引ける。
3. **ILL（相互貸借）で現物を取り寄せる。** Brandeis の案内（`guides.library.brandeis.edu/c.php?g=301735&p=2013446`）
   は、非 Brandeis 利用者について **`ill@brandeis.edu` へ依頼**する経路を示している
   （ただし ProQuest の許諾確認が先、と書かれている）。日本からなら NACSIS-ILL・国立国会図書館の
   海外文献複写でも同じ現物（OCLC 10088994）を指定できる。**93 leaves と分かっているので複写量も見積もれる。**
4. **著者本人に依頼する。** 著者 Albert (Al) Cuoco は存命で、**Education Development Center（EDC,
   55 Chapel Street, Newton, MA 02458）の Center for Mathematics Education** に所属している
   （公開プロフィール上の連絡先は `alcuoco@edc.org`）。**外部への送信＝対外的な行為なので、
   私からは連絡していない。** ユーザーが望むなら文面は用意する。

**なお、§3 の結論により、上の 1〜4 のどれも本論文の既出性判定には必要ない。**
学位論文が要るのは「$m_0$ の歴史をさらに遡る」場合だけで、本論文はそこに依存していない。

---

## 3. 【本題】定理 W4 と (K3) の既出性は、学位論文を読まずに決着する

cycle 22 が「学位論文を読まない限り『文献に無い』と言い切れない」と隔離した論点は、
**論点の立て方そのものが必要以上に強かった。** 決め手は次の 2 つの一次情報である。

### 3.1 Monsky (1981) は「$l_0$ を導入するのは自分だ」と書いている

P. Monsky, *Some Invariants of $\mathbb{Z}_p^d$-Extensions*, Math. Ann. **255**, 229–233 (1981)、
**p.229（Introduction）の原ページ画像**より:

> Cuoco, **[2]**, introduced an invariant $m_0(L/k)$ which when $d=1$ reduces to Iwasawa's $\mu(L/k)$. …
>
> A still unresolved problem is whether the $\lambda(K/k)$, $K$ ranging over all $\mathbb{Z}_p$-extensions of $k$,
> are bounded. **To tackle this we introduce an invariant $l_0(L/k)$ of a $\mathbb{Z}_p^d$-extension**, which
> reduces to Iwasawa's $\lambda(L/k)$ when $d=1$. When $d=2$ we show that the $\lambda(K/k)$, $K\subset L$, are
> bounded if and only if $l_0(L/k)=0$. (Unfortunately we do not know any examples of $\mathbb{Z}_p^d$-extensions
> with $d\ge2$ and $l_0\neq0$. Cuoco **[2]** however has shown how to construct $\mathbb{Z}_p^2$-extensions with
> arbitrarily large $m_0$.)

ここで **`[2]` は Cuoco 1980（Compositio Math. 41）である**（同論文 p.233 の References を直読して確認）。
つまり **Monsky は $m_0$ を Cuoco 1980 に帰属させ、$l_0$ は自分が導入すると明言している。**

### 3.2 Monsky (1981) の References に Cuoco の学位論文は無い

同 p.233 の References（**原ページ画像を直読**）は全 5 件:

> 1. Babaičev, V. … 2. **Cuoco, A.: The growth of Iwasawa's invariants in a family. Compositio Math. 41, 415–437 (1980)**
> 3. Cuoco, A., Monsky, P.: Class numbers in $\mathbb{Z}_p^d$-extensions … 4. Greenberg, R. … 5. Monsky, P.: On p-adic power series …

**学位論文は 1 件も挙がっていない。** Monsky は Cuoco と同じ Brandeis の数学教室に所属し
（同論文の著者所属が "Department of Mathematics, Brandeis University"）、Cuoco の指導教員は
Greenberg だが、**Monsky は学位論文の内容を知る立場にありながら、$l_0$ について学位論文を引いていない。**

### 3.3 したがって W4 と (K3) は学位論文にはない

定理 W4（$j^*(P)=m_u$、すなわち $\chi^{u^\perp}-1$ の**重複度**による点ごとの同定）も、
(K3)（$\bar{\tilde E}$ の係数から $l_0$ を与える二項式因子の候補を有限手続きで決める）も、
**$l_0$ という不変量が存在してはじめて述べられる主張**である。
$l_0$ は **Monsky が 1981 年（受理 1980-07-02）に導入した**のだから、
**1979 年の学位論文にそれらが書かれていることはありえない。**

**この推論の強さを正直に書く。** これは**帰属の記述と参考文献表からの演繹**であって、
**学位論文を読んだ結果ではない。**残る論理的な穴は 2 つで、どちらも本論文の主張には影響しない。

1. 学位論文が $l_0$ に相当する量を**別の名前で・定理として述べずに**含んでいた可能性。
   ただしその場合でも、Monsky が「we introduce」と書いた以上、**文献上の帰属先は Monsky 1981 である。**
2. **$d=2$ に限れば**学位論文（表題からして $\mathbb{Z}_p^2$-extensions が対象）に $\lambda$ の非有界性の
   議論があった可能性。しかしそれこそ Monsky が **Theorem III・IV（$d=2$）** として自分の結果に
   数えている内容であり、Monsky が Cuoco の学位論文を引かずに書いている以上、同じ結論になる。

### 3.4 CM (1981) の "originally introduced in [1, 5]" の正しい読み方

Cuoco–Monsky, **p.252**（第 5 章の末尾。Theorem I の証明の直後）:

> The invariants $m_0(L/k)$ and $l_0(L/k)$ **were originally introduced in [1, 5]**. For further information
> about them and their applications to the study of $\mathbb{Z}_p$-extensions **see [2, 5]**.

- **[1]** = Cuoco の学位論文（1979）、**[2]** = Cuoco 1980、**[5]** = Monsky *Some invariants* 1981。
- §3.1 と §3.2 を踏まえると、この一文は **「$m_0$ は [1]（学位論文）、$l_0$ は [5]（Monsky）が最初に導入した」**
  と読むのが唯一整合的である。2 つの不変量と 2 つの文献が**この順で対応している。**
- そして**「詳細（further information）」の参照先は [2, 5] であって [1] ではない。**
  **[2] も [5] も本 step で読める状態にある**（[2] は §4 で全文通読、[5] は cycle 22 が全 5 ページ通読済み）。

**呼び出し元の指示は「CM が p.248 で $m_0$・$l_0$ の詳細についてそこ（学位論文）を指している」としていたが、
一次情報はそう書いていない。** ページ番号（p.248 ではなく p.252）も、参照の向き（詳細は [2,5] であって [1] ではない）も違う。
**この step の前提そのものが誤っていた。**

---

## 4. Cuoco 1980（Compositio Math. 41, 415–437）を全文読んだ

cycle 22 は Introduction と Theorem 1.1 周辺しか読んでいなかった。**本 step で全 23 ページを通読した。**
NUMDAM の PDF から `pdftotext -layout` でテキスト化し（1,615 行）、疑わしい箇所は PDF を直接見た。

**構成**: §1 Introduction（pp.415–420）／§2 モジュール論の準備（pp.420–429、Proposition 2.1・
Lemma 2.2–2.8・**Proposition 2.9**）／§3 Galois groups and Iwasawa invariants（pp.429–432、Theorem 1.1 の証明）／
**§4 The $m_0$-invariant**（pp.432–437、Proposition 4.1–4.7・Corollary 4.8–4.10・末尾の考察）／References。

### 4.1 (K3)・W4 に該当するものは無い

**Theorem 1.1**（p.416）:

> There are constants $t$, $m_0$, $m_1$, $c$, and $c_1$, independent of $n$, such that for all sufficiently
> large $n$, $\lambda_n = tp^n + c$ and $\mu_n = m_0p^n + m_1n + c_1$.

同 p.416 が自分で予告しているとおり、**この論文が精密に記述するのは $m_0$ だけ**である:

> We will also be able to give **a precise description of the invariant $m_0$**, and to show that it depends
> only on $K/k$ … The rest of the paper is devoted to some consequences of Theorem 1.1 and **to a description of $m_0$**.

**$m_1$ は Theorem 1.1・Proposition 2.9・§3 の適用（p.431）・§4 の一箇所（p.436）にしか現れず、
最後まで一度も特徴づけられない。** §4 の表題は "The $m_0$-invariant" であり、$m_1$ に充てられた節は無い。
p.429 の Remark も $m_0$ だけを取り出す:

> an analysis of the proof of Proposition 2.9 shows that if $\mu(W/a_nW)=m_0p^n+m_1n+c$, then **$m_0$** is the
> power of $p$ dividing the characteristic power series of $Z$ (i.e., of $W$). This will be useful in §4.

論文末尾（p.437）は、残った不変量について**未解決だと自認して終わる**:

> The question naturally arises as to whether or not anything can be said about $t(k_\infty,k'_\infty/k)$. … **I have
> been unable to find such examples.**

**したがって Cuoco 1980 に (K3)・定理 W4 に相当するものは無い。読んだ範囲＝全文である。**

### 4.2 罠を 1 つ避けた: $m_1$ と $l_0$ を同一視してはならない

Cuoco の $m_1$（$\mu_n$ の $n$ の係数）と CM の $l_0$（$e_n$ の $n$ の係数）は、**式の見た目が同型だが
対象が違う。** CM (1981) p.249 の原文（**ページ画像を直読**）:

> Let $F$ be the characteristic power series of $X$, $m_0(L/k)=m_0(F)$ and $l_0(L/k)=l_0(F)$. Then $m_0$ and $l_0$
> are **generalizations of the Iwasawa invariants $\mu(L/k)$ and $\lambda(L/k)$** to the case of arbitrary $d$. …
> Our aim is to show that $e_n(L/k)=(m_0p^n+l_0n+O(1))p^{(d-1)n}$.

**$l_0$ は $\lambda$ の一般化**であり、Cuoco の $m_1$ は **$\mu_n$ の展開の項**である。
両者が一致するという保証はどこにも書かれていない。**「$m_1=l_0$ だから Cuoco 1980 が $l_0$ を扱っている」
という推論は成り立たない**——そしてその推論は不要である（§3 で決着済み）。

### 4.3 ついでに確認できたこと（本文へ書くべきか、step 1 の判断材料）

Monsky (1981) p.229 の括弧書き:

> (Unfortunately **we do not know any examples of $\mathbb{Z}_p^d$-extensions with $d\ge2$ and $l_0\neq0$.**
> Cuoco [2] however has shown how to construct $\mathbb{Z}_p^2$-extensions with arbitrarily large $m_0$.)

1981 年時点で、**$l_0\neq0$ の例が 1 つも知られていなかった**という一次情報である。
本論文の $S_\infty$ が空でない状況は、まさに $l_0>0$ に対応する（cycle 22 §2 で $b=l_0$ の同定済み）。
**voltage グラフの側では $\bar{\tilde E}$ が二項式因子を持つ例を明示的に構成できる**（cycle 20–22 の
sagemath 検証がそれを実際に走らせている）。**本文の「限界」節に書く価値がある可能性はあるが、
本 step は本文を触らないので書いていない。** 判断は step 1 に委ねる。ただし次の点を必ず確認すること:

- 上の引用は **$\mathbb{Z}_p^d$-extension of a number field**（数体の塔）についての言明であり、
  **グラフの voltage 被覆についてではない。** 両者は Kataoka の対応で結ばれるが同一ではない。
  **数体側で $l_0\neq0$ の例が今日どうなっているかは、本 step では調べていない**（§5 の未読範囲）。
- したがって「未解決だった」と本文に書いてはならない。書けるのは「1981 年の Monsky は $d\ge2$ かつ
  $l_0\neq0$ の**数体の**例を知らないと書いている」という事実だけである。

---

## 5. 読んだ範囲と読んでいない範囲（明示する）

| 文献 | 取得 | 読んだ範囲 | 読んでいない範囲 |
|---|---|---|---|
| Cuoco, *Some contributions to the theory of $\mathbb{Z}_p^2$-extensions*, Brandeis thesis (1979), v+93 leaves | **未取得** | **無し**（ProQuest の索引にある 1 文の抄録のみ。それは Cuoco 1980 の冒頭文と同一で内容を含まない） | **全 93 leaves** |
| Cuoco, Compositio Math. **41**, 415–437 (1980) | 取得（NUMDAM） | **全文 pp.415–437**（§1–§4・References） | 無し |
| Monsky, *Some invariants of $\mathbb{Z}_p^d$-extensions*, Math. Ann. **255**, 229–233 (1981) | 取得（GDZ IIIF） | cycle 22 が全 5 ページ。**本 step は p.229（Introduction）・p.230（Definition 1.1–1.3）・p.233（Theorem I–IV と References）を原画像で読み直した** | 無し |
| Cuoco–Monsky, Math. Ann. **255**, 235–258 (1981) | 取得（GDZ IIIF） | cycle 22 が全 24 ページ。**本 step は p.248・p.249・p.250・p.252・p.258 を原画像で再確認した**（p.252 の "originally introduced" の文と p.258 の References が本 step の根拠） | 無し |
| Monsky, *On p-adic power series*, Math. Ann. **255**, 217–227 (1981) | cycle 16 が取得 | cycle 16 の範囲のまま（Def. 3.1, Thm 3.4, 5.5, **5.6**, Remark 1–2, References） | §1–§2, §4 |

**「学位論文に無い」と本 step が言えるのは、§3 の演繹（帰属の記述と参考文献表）によってであり、
本文を読んだからではない。** この区別を本文へ書くときも保つこと。

---

## 6. 再現手順（本 step が使ったもの）

**壁時計はいずれも 1 分未満。20 分の設計上限に対して分割不要だった。**

```bash
# (1) Cuoco 1980 全文（無料）
curl -sL -o cuoco1980.pdf "https://www.numdam.org/item/CM_1980__41_3_415_0.pdf"
pdftotext -layout cuoco1980.pdf cuoco1980.txt      # 1615 行、可読

# (2) Math. Ann. 255 のページ画像（無料）。ページ番号 → 画像番号のオフセットは +4
#     Monsky p.229/230/233 → 00000233/00000234/00000237
#     Cuoco-Monsky p.248/249/250/252/258 → 00000252/00000253/00000254/00000256/00000262
curl -s -o p.jpg "https://images.sub.uni-goettingen.de/iiif/image/gdz:PPN235181684_0255:00000256/full/full/0/default.jpg"

# (3) OCR は macOS Vision（VNRecognizeTextRequest, .accurate, usesLanguageCorrection=false）の
#     20 行の Swift。地の文と References は十分読めるが数式は信用できない。
#     結論の根拠にした箇所（p.229 の Introduction, p.233 の References, p.252 の当該文, p.249, p.258）は
#     すべてページ画像を直読して確認した。

# (4) Brandeis 目録（無料・認証不要の公開 API）
curl -H 'Accept: application/json' "https://brandeis.primo.exlibrisgroup.com/primaws/rest/pub/pnxs?\
inst=01BRAND_INST&lang=en&limit=20&offset=0&q=any,contains,Cuoco%20contributions%20theory%20extensions&\
scope=MyInst_and_CI&tab=Everything&vid=01BRAND_INST:BRAND"
```

---

## 7. 本文へ書くべきこと（**本 step は書かない**。step 1 への申し送り）

**本サイクルでは本文を触ってよいのは step 1 だけなので、以下は文面案として置くだけである。**
現状の本文（命題 K の「限界」）は cycle 22 が
「**(K3)・(K4)・(K5)・(K7) は読んだ範囲に無い。Cuoco の学位論文は読んでいない**」と書いている。
これは**いまや不必要に弱い**ので、次の主旨へ差し替えられる。

> $l_0$ は Monsky *Some invariants of $\mathbb{Z}_p^d$-extensions* (1981) が導入した不変量である
> （同論文 p.229「To tackle this we introduce an invariant $l_0(L/k)$」）。$m_0$ の方は Cuoco に帰属する
> （同 p.229、および Cuoco, Compositio Math. **41** (1980)）。**したがって $l_0$ の局所構造に関する
> (K3)・(K4)・(K5)・(K7)・定理 W4 は、$l_0$ の導入より前の文献にはありえない。**
> $l_0$ を扱う文献は Monsky (1981) と Cuoco–Monsky (1981) の 2 篇であり、**その両方を通読した範囲には無い。**

**この文面をそのまま使う前に、step 1 は次を必ず自分で確かめること**（cycle 18・20・21・22 で
転記事故が繰り返し起きている型である）:

1. 上の引用 2 箇所（Monsky p.229 の "To tackle this we introduce…" と "Cuoco, [2], introduced an invariant $m_0$"）を、
   **§6 の手順でページ画像を取り直して直読する。** 本 report の OCR をそのまま信じない。
2. Monsky p.233 の References に**学位論文が無いこと**を自分の目で確認する（本 report の主張の要）。
3. cycle 22 が本文へ書いた「Cuoco の学位論文を読んでいない」という記述は**削らずに残す**。
   §3.3 のとおり、決着したのは「$l_0$ の話は学位論文にありえない」であって、
   **学位論文を読んだわけではない。** 読んでいないという事実の記述は依然として正しい。
4. **ページ番号を p.248 から p.252 へ直す**（cycle 22 report の誤記が本文へ伝播していないか確認する）。
5. §4.3 の Monsky の括弧書きを引くなら、**「数体の塔について」という限定を落とさない。**

**書誌データ（`outputs/papers/001_R_Lambda_duality/refs.bib`）についても本 step は触っていない。**
学位論文を新規エントリとして加えるなら、§1 の同定情報（表題・v+93 leaves・OCLC 10088994・
UMI 8013627・ProQuest 288025998・授与年 1979／UMI 製本 1980）が使える。
**ただし本文が学位論文を引用する必要はない**（§3 のとおり依存しない）ので、加えるかどうかは step 1 の判断である。

---

## 8. 自分が犯した誤り（隠さず記録する）

1. **step の前提を裏取りせずに作業を始めかけた。** 指示にある「CM が p.248 で $m_0$・$l_0$ の詳細について
   学位論文を指している」を確かめるため p.248 の画像を取ったところ、**そこは第 5 章の冒頭**で当該文が無かった。
   cycle 22 report の記述（「§5 末尾（p.248）」）も同じ誤りを含んでいた。**§5 の残りを OCR して p.252 に
   実在を確認するまで、私は cycle 22 の書き写しを一次情報として扱いかけていた。**
   （cycle 23 の申し送り「着手時に根拠 report を読んで前提を裏取りする」が、まさにこれを防いだ。）
2. **$m_1=l_0$ という同一視をしかけた。** Cuoco 1980 の $\mu_n=m_0p^n+m_1n+c_1$ と
   CM の $(m_0p^n+l_0n+O(1))p^{(d-1)n}$ が同型に見えたためである。
   **CM p.249 が「$l_0$ は $\lambda$ の一般化」と明記している**のを読んで取り消した（§4.2）。
   この同一視をしていたら「Cuoco 1980 が $l_0$ を扱っている」という誤った既出性判定を出していた。
3. **HathiTrust を Web の検索 UI から叩いて Cloudflare のチャレンジに当たり、「到達不能」と書きかけた。**
   実際は Bib API（`catalog.hathitrust.org/api/volumes/brief/oclc/...`）が認証不要で応答し、
   **収録なしという確定的な答え**を返した。**UI の失敗を「確認できない」と読むのは誤りだった。**
4. **OCR の出力を引用文としてそのまま report に書いた。** 本 report の初稿は、Monsky p.229 の
   「Cuoco [2] however has shown how to construct **$\mathbb{Z}_p^2$**-extensions with arbitrarily large $m_0$」を、
   OCR が落とした肩の 2 のまま「$\mathbb{Z}_p^d$-extensions」と書いていた。**その後 p.229・p.233・p.252 の
   3 ページをページ画像で直読して全引用を照合し、この 1 件を直した。** cycle 22 report は
   「数式の OCR は信用できないので結論の根拠にした箇所はページ画像を直読した」と書いており、
   **私は同じ規律を初稿で守れていなかった。**（他の 2 ページの引用に食い違いは無かった。）
5. **WorldCat の所蔵館一覧を取れなかったことを、最初「所蔵館が無い」と書きかけた。** 実際は
   `/api/search-item-holdings` がトークンを要求して "Oops, something went wrong" を返しただけで、
   **所蔵の有無は確認できていない。** 「取得できなかった」と「存在しない」を分けて §2 の表に書き直した。

---

## 9. 残ったこと（次に何が妨げているか）

1. **学位論文の本文は依然として未取得である。** §2.1 の 4 経路のいずれもユーザーの判断・資格・課金を要する。
   **ただし本論文の既出性判定には不要になった**（§3）。読む価値があるのは
   「$m_0$ の元々の定義と、Cuoco 1980 に載らなかった 70 ページ分に何があるか」という別の問いである。
2. **§4.3 の「$l_0\neq0$ の例」の現在の状況を調べていない。** Monsky 1981 の「例を知らない」という
   記述が 45 年後の今どうなっているか（数体側で $l_0\neq0$ の例が構成されたか）は未調査である。
   これは本文の位置づけに効きうるので、**cycle 24 の候補として挙げる。**
3. **cycle 22 report のページ番号の誤記（p.248 → p.252）を、本 step は直していない。**
   根拠 report を触ってよいのは step 1 だけだからである。**step 1 が cycle 22 report の §4 も直すこと。**
4. **Monsky *On p-adic power series* の §1–§2・§4 は依然として未読**（cycle 16 以来）。
   cycle 22 §10-2 が挙げた「CM Theorem 1.7 の証明と cycle 21 の初等証明の異同」は手つかずのままである。
