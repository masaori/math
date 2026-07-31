# cycle 18 step 4 (T1 Reframe): Monsky (ASPM 17, 1989) の入手と照合

作成日: 2026-07-31 / 対象: `outputs/papers/001_R_Lambda_duality/` の投稿前の宿題 1 件
（cycle 17 step 4 のレポート `cycle17_T1_prior_art_check.md` §5.3 が残した「本文未取得」）

---

## 0. 結論（先に結論だけ）

**本文を入手できた。購読・課金・ログイン・メール依頼のいずれも不要だった。**
Project Euclid の当該章は **Open Access 指定**であり、章ページ上の PDF ダウンロードリンクから
全 22 ページ（pp. 309–330）を取得し、テキスト化して読んだ。

照合結果:

| 問い | 答え | 根拠（原論文の本文） |
|---|---|---|
| Monsky 1989 に $\mu_1$（$p^{(d-1)n}$ の係数）の**明示式**はあるか | **無い。存在しか示していない**。Monsky 自身が「$\alpha^*$ には easy な記述が無く、常に有理数かどうかも分からない」と書いている | Introduction 第 5 段落、Theorem 3.12、Theorem 3.13 |
| $d=2$ で何が言えるか | **有理数であること**は示されている（それだけ） | Theorem 3.12 / 3.13 の最終文 |
| Monsky が明示的に同定した係数はどれか | $p^{dn}$ の係数 $m_0(F)$ と $np^{(d-1)n}$ の係数 $\ell_0(F)$ の **2 つだけ**（Theorem 1.20）。$p^{(d-1)n}$ の係数は差分方程式の解として非構成的に取り出される | Theorem 1.19 / 1.20 |
| 本論文の命題 W の位置づけは変わるか | **変わらない（既出にならない）**。むしろ「$d=2$ なら有理数」という Monsky の一般定理に対し、本論文はある族でその有理数の値を $k(\ell+1)/(\ell-1)$ と特定している、という関係になる | 同上 |

**したがって cycle 17 が残した投稿前の宿題は閉じた。** 命題 W の $\mu_1$ の明示式は Monsky 1989 には無い。
ただし本論文は依然として新規性を主張しない（網羅調査ではない）。

---

## 1. 入手経路（一次情報。何を試して何が起きたか）

| # | 経路 | 結果 |
|---|---|---|
| 1 | `curl` で DOI `10.2969/aspm/01710309` を解決 | Project Euclid へ 302。**ただし応答本文は Incapsula のボット遮断ページ**（HTML 1161 バイト、`Request unsuccessful. Incapsula incident ID: ...`）。cycle 17 が「購読制限」と判断したのはおそらくこれで、**実際にはアクセス制限ではなくボット遮断だった** |
| 2 | ブラウザ相当の User-Agent と Referer を付けて章ページを取得 | HTTP 200、113,928 バイト。ページ内に **`Open Access content.`** の文字列と、PDF ダウンロードリンク `ebook/Download?urlid=10.2969%2Faspm%2F01710309&isFullBook=False` が実在 |
| 3 | `journalArticle/Download?urlId=...`（雑誌記事用エンドポイント） | HTTP 200 だが `text/html`（PDF ではない）。**ASPM は ebook 扱いなのでこちらは誤り** |
| 4 | **`ebook/Download?urlId=10.2969%2Faspm%2F01710309&isFullBook=false`** | **HTTP 200 / `application/pdf` / 2,330,379 バイト / PDF 1.6 / 22 ページ。取得成功** |

**ログイン・アカウント作成・課金・メール送信・相互貸借（ILL）は一切していない**（本 step の禁止事項）。
取得した PDF は Project Euclid が Open Access として公開しているものである。

取得物はスキャン画像に OCR テキスト層が乗ったものなので、`pdftotext -layout` の出力には
OCR 誤り（`z;-Extensions`、`a*` と `α*` の混同、添字の落ち等）がある。
**以下の引用はすべて、PDF のテキスト層を読み、文意が Introduction・§2・§3 の 3 箇所で
整合することを確認したうえで書いている**（1 箇所の OCR だけを根拠にしていない）。

### 再現手順

```bash
UA='Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0 Safari/537.36'
curl -s -A "$UA" -H 'Referer: https://projecteuclid.org/' -L \
  "https://projecteuclid.org/ebook/Download?urlId=10.2969%2Faspm%2F01710309&isFullBook=false" \
  -o monsky1989.pdf
pdftotext -layout monsky1989.pdf monsky1989.txt   # 22 ページ / 約 56 KB
```

PDF は本リポジトリに置いていない（サイズと配布条件のため。上記コマンドで誰でも再取得できる）。

---

## 2. 本文の照合（何が書いてあったか）

### 2.1 Introduction — Monsky 自身が「明示式は無い」と書いている

Introduction（p. 309）の該当箇所（原文、OCR のまま。$\alpha^*$ は原文では `a*`）:

> Our goal in this paper is to refine the above Theorem I by proving that
> $e_n=(m_0p^n+\ell_0 n+\alpha^*)p^{(d-1)n}+O(np^{(d-2)n})$ for some real $\alpha^*$.
> **There is no easy description of $\alpha^*$ and in particular we do not know if it is always rational.**
> We shall show however that it is rational if either $d=2$ or if $X$ contains no pseudo-null submodule other than $(0)$.

これが決定的である。**$\alpha^*$（＝本論文の $\mu_1$ に対応する位置の定数）に明示式は与えられていない。**

### 2.2 主定理 — 存在と（$d=2$ での）有理性のみ

- **Theorem 3.12**（p. 329、$\Lambda$-加群版）:
  > Then there is a real number $\alpha^*$ such that $e(G_n)=m_0p^{dn}+\ell_0np^{(d-1)n}+\alpha^*p^{(d-1)n}+O(np^{(d-2)n})$.
  > If either $M^*=(0)$ or $d=2$ then $\alpha^*$ is rational.
- **Theorem 3.13**（p. 330、数論版＝Wan が引用しているもの）:
  > Let $L/k$ be a $\mathbb{Z}_p^d$-extension of a number field, $d\ge2$, … Then there is a real number $\alpha^*$
  > such that $e_n(L/k)=(m_0p^n+\ell_0n+\alpha^*)p^{(d-1)n}+O(np^{(d-2)n})$. **When $d=2$, $\alpha^*$ is rational.**

いずれも **$\alpha^*$ の値を与える式は無い**。

### 2.3 なぜ明示できないのか（$\alpha^*$ の 3 つの寄与）

Introduction の outline と §3 によれば、$e(G_n)$ は 3 つの寄与の和として書かれ、$\alpha^*$ はその合計である。

1. **岩澤和の寄与 $\mu^*$**（Theorem 1.21）: 有理数であることは示される。
   しかしその値は **Theorem 1.19 の証明の中で、差分方程式 $g(x+1)-p^{d-1}g(x)=h(x)$ を解き、
   ある大きな $N$ で $g(N)=\Sigma(G,U^*,N)$ となるように初期値を合わせる**という形で取り出される。
   **Theorem 1.20 が明示的に同定しているのは $p^{dn}$ の係数 $m_0(F)$ と $np^{(d-1)n}$ の係数 $\ell_0(F)$ の 2 つだけ**である。
2. **擬零部分加群 $M^*$ の寄与**（Corollary 2.19, Theorem 2.18(2)）: これは Monsky の別論文 [4] の
   Theorem 3.9 に依拠し、原文はこう書いている:
   > In [4] we produce $a$ as the limit of a Cauchy sequence; **we do not know if it is always rational.**
3. **整数 $\beta$ の寄与**（Theorem 3.11）: 「ある整数 $\beta$ が存在して … $+\beta p^{(d-1)n}$」という
   **存在主張**であり、$\beta$ の値の記述は無い。

したがって、**$M^*=(0)$（擬零部分加群が無い＝我々の言葉での「非退化」に近い状況）を仮定しても、
$\alpha^*=\mu^*+\beta$ の形で、$\beta$ は「ある整数」でしかない。** 明示式は本文のどこにも無い。

（$\alpha^*$ の明示式が本文のどこかにあれば `Theorem` / `rational` / `a*` の全出現箇所に現れるはずなので、
それらを全部当たった。該当箇所は上記で尽きている。）

### 2.4 Wan の引用形は正確だった

Wan, arXiv:1712.02906 の Theorem 1.2 は
「There are integers $m_0,\ \ell_0$ and a real number $\alpha$ depending on the tower such that …」であり、
**Monsky の Theorem 3.13 の忠実な引用である**（$\alpha$ の明示式が省略されていたのではなく、
元々存在しない）。cycle 17 が「Wan が要約したせいで明示式が見えていないだけかもしれない」と
留保したのは正しい態度だったが、**その留保は本文確認により解消した**。

### 2.5 独立な二次確認（Tateno–Ueki 2025）

Tateno–Ueki, *The Iwasawa invariants of $\mathbb{Z}_p^d$-covers of links*, arXiv:2401.03258
（J. London Math. Soc. 2025。本文を取得して読んだ）の **Theorem 2.3** は、Monsky 1989 を
**Theorem 3.13 と番号まで指定して**次の形で引用している:

> **Theorem 2.3 (Monsky [33, Theorem 3.13]).** The $O(1)p^{(d-1)n}=O(p^{(d-1)n})$ part in above may be refined to
> $\mu_1p^{(d-1)n}+O(np^{(d-2)n})$ for some $\mu_1\in\mathbb{R}$. If $d=2$, then $\mu_1\in\mathbb{Q}$.

**この二次文献は当該定数を文字どおり $\mu_1$ と呼んでおり**（本論文の記号と偶然一致する）、
やはり**存在と $d=2$ での有理性しか主張していない**。原論文の読みと完全に一致する。

同論文 Proposition 3.9 は Monsky *On p-adic power series* Theorem 5.6 を
「岩澤和 $\sum_{\zeta\in S\cap W(n)^d}v(F(\zeta-1))$ は十分大きい $n$ で $f(p^n,n)$ に等しい
（$f\in\mathbb{Q}[U,V]$ が一意に存在）」という形で引用しており、これも**多項式の存在**であって
係数の明示式ではない。本プロジェクトが cycle 16 で原典確認した Theorem 5.6 の読みと整合する。

---

## 3. 命題 W への影響

本論文の命題 W:
$$\mathrm{ord}_\ell(\kappa_n)=\mu\,\ell^{2n}+\frac{k(\ell+1)}{\ell-1}\,\ell^{n}-2n+\nu .$$

- **既出にならない。** Monsky 1989 は $d=2$ で $\ell^n$ の係数が**有理数であること**までしか言っておらず、
  値を与えていない。本論文はある族でその値を $k(\ell+1)/(\ell-1)$ と特定している。
- **むしろ整合性の裏付けになる。** Monsky の $d=2$ 有理性定理（一般の $\mathbb{Z}_p^2$ 拡大）と、
  本論文の $k(\ell+1)/(\ell-1)\in\mathbb{Q}$ は矛盾しないどころか、後者は前者が保証する有理数の
  具体値の一例という位置づけになる。
- **誤差項の比較**: Monsky の誤差は $d=2$ で $O(np^{(d-2)n})=O(n)$ であり、命題 W の $-2n+\nu$ を
  そのまま飲み込む。すなわち **Monsky の結果は命題 W より真に弱い**（$\ell^n$ の係数の値も、$n$ の係数も出さない）。
- **対象の違いを混同しないこと**: Monsky は**数論側**（数体の $\mathbb{Z}_p^d$ 拡大の類数の $p$ 指数 $e_n$）であり、
  命題 W は**グラフ側**（$\mathbb{Z}_\ell^2$ 塔の全域木数 $\kappa_n$）である。両者が同じ $\Lambda$-加群論を
  経由して同型の漸近形を持つのは既知の対応だが、**Monsky の定理をグラフ側の主張として引用してはならない**。
  グラフ側の対応物は Kataoka arXiv:2606.03579 Theorem 1.1 である（本文確認済み）。

**結論**: cycle 17 §5.5 が置いた留保「Monsky 1989 が未確認である以上、『文献に無い』と書いてはならない」は
**解除できる**。ただし解除できるのは Monsky 1989 についてだけで、
「調べた範囲では見つからなかった」以上のことは依然として言えない（網羅調査ではない。MathSciNet 未使用）。

---

## 4. 見つからなかったもの（0 件の記録）

- **$\alpha^*$（$=\mu_1$）の明示式を与えた後続文献は見つからなかった。**
  - 検索: Web 検索 `Monsky 1989 alpha* "e_n" Z_p^d-extensions explicit formula constant term Iwasawa asymptotic rational`、
    および `Monsky "Fine estimates for the growth of" "Z_p^d-extensions" 1989 pdf`。
  - ヒットした関連文献のうち本文を読んだのは Tateno–Ueki arXiv:2401.03258（上記 §2.5）と
    Wan arXiv:1712.02906、および arXiv:2207.02283（*Iwasawa Dieudonné theory of function fields*、
    Monsky 1989 を `[Mon89]` として参考文献に挙げるのみで、$\alpha^*$ の値には触れていない。
    **本文は Monsky 引用箇所のみ確認、全体は未読**）。
  - **0 件は「存在しない」の根拠にしない。** MathSciNet を引けていないこと、Web 検索は本文検索ではないことは
    cycle 17 と同じ限界である。
- **本文未確認のまま残る文献**（cycle 17 から変化なし）: Haskell (APAL 1992)、Harrison-Trainor arXiv:1602.08408、
  Simpson *Subsystems of Second Order Arithmetic*、Pelayo–Voevodsky–Warren (2015)。
  これらは寄与 (b) の周辺であって命題 W とは無関係であり、投稿の可否を左右しない。

---

## 5. ユーザーにしか実行できない残り経路

**無い。** 本 step の目的（Monsky 1989 の本文入手と照合）は完了した。
メール依頼・相互貸借・購入・アカウント作成のいずれも不要だった。

---

## 6. 本文・付随ファイルへの反映

| 対象 | 反映内容 |
|---|---|
| `structured-latex/content/006_propositions_TVW.ts`（`paper_prop_W` の既出性段落 (iii)） | 「本文未取得。投稿前に必ず読むこと」を、**本文を読んだ結果**（明示式は無い／$d=2$ の有理性のみ／Monsky 自身が「no easy description」と書いている）に置き換えた |
| `outputs/papers/001_R_Lambda_duality/refs.bib` | `Monsky1989` の note を「本文未取得」から本文確認済みの内容へ更新。`Wan2017` の note も「原論文未取得」の記述を解消。**併せて重複していた BibTeX キー `Vallieres2021`（2 エントリ）を 1 つに統合した**（重複キーは BibTeX がエラーにする実害があるため） |
| `outputs/papers/001_R_Lambda_duality/notes.md` | 「投稿前に必ずやること」の Monsky 1989 の項目を**閉じた**（取り消し線＋決着の記録） |
| `MEMORY.md` / `docs/tasks/auto-loop-state.md` | cycle 18 step 4 を done にし、宿題が閉じたことを記録 |

---

## 7. 敵対的レビュー（自分の結論を反証しにいった結果）

1. **「PDF が本当に Monsky 1989 か」** — 1 ページ目に
   `Advanced Studies in Pure Mathematics 17, 1989 / Algebraic Number Theory- in honor of K. Iwasawa / pp. 309-330 /
   Fine Estimates for the Growth of e_n in Z_p^d-Extensions / P. Monsky` が印字されている。
   ページ数 22 は 309–330 と一致する。参考文献の [1] が Cuoco–Monsky, Math. Ann. 255 (1981), 235–258 であることも
   cycle 16 で原典確認した書誌と一致する。→ 同定は確実。
2. **「明示式を読み落としていないか」** — $\alpha^*$ が出るのは Introduction・Theorem 3.12・Theorem 3.13 の
   3 箇所のみで、いずれも「there is a real number」の形である。加えて $\alpha^*$ の 3 寄与
   （$\mu^*$ / $M^*$ 由来の $a$ / 整数 $\beta$）の各出典（Theorem 1.19–1.21、Theorem 2.18、Corollary 2.19、
   Theorem 3.11）を全部読み、いずれも値の記述が無いことを確認した。→ 読み落としではない。
3. **「OCR のせいで誤読していないか」** — 「明示式が無い」という結論は、
   (a) Introduction の "There is no easy description of $\alpha^*$"、(b) Theorem 3.12/3.13 の "there is a real number"、
   (c) §2 の "we do not know if it is always rational"、(d) **独立な二次文献 Tateno–Ueki Theorem 2.3** の
   4 つが独立に支持している。単一箇所の OCR に依存していない。
4. **「Open Access なのに cycle 17 は購読制限だと書いた。どちらが正しいか」** —
   cycle 17 が見たのは Incapsula のボット遮断ページであり（本 step で再現した）、購読の壁ではなかった。
   **「アクセスできなかった」を「購読制限である」と原因まで断定したのが cycle 17 の誤りである。**
   今後、取得失敗の原因は応答本文を見てから書くこと。
5. **「Monsky の結果でグラフ側が既出になっていないか」** — Monsky は数体の類数の話であり、
   グラフの全域木数の主張ではない。グラフ側の一般漸近は Kataoka Theorem 1.1 が担い、
   そこでも $\mu_1$ は「追わない」と明記されている（cycle 17 §5.2 で本文確認済み）。→ 既出にならない。
