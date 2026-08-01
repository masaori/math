# cycle 22 / T3 Pure: Cuoco–Monsky への帰属の書き足しと、定理 W3・W4 の既出性の決着

対象: cycle 22 step 1（`cuoco_monsky_attribution`）。
根拠 report: `cycle21_T3_drop_assumption_B_star.md`（とくに §11 と §13-3）、
`cycle20_T3_s_infinity_decision.md`（定理 W3・W4・系 W6）、
`cycle16_T1_monsky_primary_sources.md`（cycle 16 が取得した原文の書き写し）。

## 0. 結論（先に置く）

| 項目 | 結果 |
|---|---|
| **命題 K (K6)（$b$ ＝原始二項式部分の次数）の帰属** | **書き足した。** Cuoco–Monsky Definition 1.2 の $l_0$ と**定義から一致**し、(K6) の等式は同論文 Theorem 1.7 の $n\ell^n$ の係数そのもの。日本語正本・英語版の両方へ書いた。 |
| **定理 W3（判定手続き）の既出性** | **決着した。半分は既出である。** 中核の同値「$\theta(P)=\infty\iff(\chi^{u^\perp}-1)\mid\bar{\tilde E}$」は **Monsky, *Some invariants of $\mathbb{Z}_p^d$-extensions*, Math. Ann. 255 (1981), 229–233 の Lemma 2.3（$d=2$）と同じ内容**である。一方 **(K3) の有限手続き（候補の列挙と $O(\lvert S\rvert^3)$ の判定）は、読んだ範囲には無い。** |
| **定理 W4（$j^*$ ＝二項式因子の重複度）の既出性** | **読んだ範囲には無い。** CM も Monsky も $l_0$ を $\bar F_0$ の素因子分解の言葉で**定義**するだけで、点ごとの $j^*$ の同定は述べていない。Monsky Lemma 2.3 の逆向き（$X_1\nmid\bar G$ の場合）は $\lambda(G_a)\le r$ という**上界**しか与えていない。 |
| **読んだ範囲** | CM 1981 は **pp.235–258 の全 24 ページ**（Introduction・§1–§7・References）。Monsky *Some invariants* 1981 は**全 5 ページ**（pp.229–233）。Cuoco, Compositio Math. 41 (1980), 415–437 は **Introduction と Theorem 1.1 の周辺**。**読んでいないのは Cuoco の学位論文（Brandeis, 1979）である。** |
| **本文で見つけた既存の不備** | **1 件（英語版）。** 命題 K の (K4) の解説で、日本語正本の「$\ell$ 進近傍」が英語版では地の文の "p-adic neighbourhood" になっていた（**素数の記号が違う**）。修正した。 |

**新規性は一切主張しない。** 本 step がやったのは、原論文を取得して読み、帰属を本文へ正しく書き、
何を読んで何を読んでいないかを明示したことだけである。

---

## 1. 一次情報の取得（再現手順）

cycle 16 と同じ経路（GDZ の IIIF）で Math. Ann. **255** (1981) のページ画像を取得した。
ページ番号と画像番号のオフセットは **+4**（p.235 → `00000239`）で、cycle 16 が記録した
「p.226 = `00000230`」と整合する。

```bash
# Cuoco–Monsky, pp.235-258 → 画像 00000239-00000262
for n in $(seq 239 262); do
  curl -s -o p$n.jpg \
    "https://images.sub.uni-goettingen.de/iiif/image/gdz:PPN235181684_0255:00000$n/full/full/0/default.jpg"
done
# Monsky, Some invariants, pp.229-233 → 画像 00000233-00000237
# Cuoco 1980（Compositio Math.）は NUMDAM から PDF で取れる（DOI は無い）
curl -sL -o cuoco1980.pdf "https://www.numdam.org/item/CM_1980__41_3_415_0.pdf"
```

**OCR は macOS の Vision フレームワーク**（`VNRecognizeTextRequest`, `recognitionLevel = .accurate`,
`usesLanguageCorrection = false`）で行う 30 行の Swift を書いて使った。地の文と節見出しは十分に読めるが、
**数式の OCR は信用できない**ので、**結論の根拠にした箇所はすべてページ画像を直読して確認した**
（§2・§3 に引用する Definition 1.1 と Lemma 2.3 がそれである）。

**壁時計**: 取得と OCR を合わせて 1 本あたり 1 分未満。20 分の設計上限に対して余裕があり、分割不要。

---

## 2. Cuoco–Monsky §1（cycle 16 が読んだ範囲。再確認）

> **Definition 1.2.** *Write $F=p^{m_0}\cdot F_0$ with $\bar F_0\neq0$. Then $l_0(F)=\sum\mathrm{ord}_P(\bar F_0)$,
> the sum extending over all $P$ of the form $(\bar\sigma-1)$, $\sigma\in E-E^p$. [In other words, $l_0(F)$ is the
> number of irreducible factors of $\bar F_0$ of the form $\bar\sigma-1$, $\sigma\in E-E^p$, counted with multiplicity.]*
>
> **Theorem 1.7.** *Suppose $F\neq0$. $\Sigma_n(F)=(m_0p^n+l_0n+O(1))p^{(d-1)n}$ where $m_0=m_0(F)$, $l_0=l_0(F)$.*

Monsky *Some invariants* p.230 の Definition 1.1(b) も同じ量を定義している（**ページ画像を直読して確認**）:

> **Definition 1.1.** *Suppose $F\neq0$ is in $\Lambda_d$. Write $F=p^{m_0}G$ with $\bar G\neq0$. Then:*
> *(a) $m_0(F)=m_0$. (b) $l_0(F)=\sum\mathrm{ord}_{\mathbf P}(\bar G)$, the sum extending over all height 1 primes
> $\mathbf P$ of $\bar\Lambda_d$ of the form $(\overline{\sigma-1})$.*

$E=\Gamma\cong\mathbb{Z}_\ell^2$ の下で $\bar\sigma-1$ は原始 $v$ についての $\chi^{v}-1$ に対応するから、
$l_0$ は本文 (K4) の $\sum_i m_i$ と**同じ量**である。よって **(K6) は Theorem 1.7 の $n\ell^n$ 係数そのもの**であり、
1981 年から知られている。これは cycle 21 step 1 §11 の同定の再確認である。

**注意（記号の衝突）**: CM の $E$ はガロア群であり、本論文の $E$（スペクトル多項式）ではない。
本文へ書くときは CM の $E-E^p$ をそのまま持ち込まず、「群の元が $p$ 冪でない（＝原始）」と言い換えた。

---

## 3. 定理 W3 の既出性 — **中核の同値は既出である**

Monsky, *Some invariants of $\mathbb{Z}_p^d$-extensions*, p.231（**ページ画像を直読**）:

> **Lemma 2.3.** *Suppose $G\in\Lambda_2$ with $\bar G\neq0$. Then $\lambda(G_a)$ is unbounded in a neighborhood
> of $(0,1)$ if and only if $X_1$ divides $\bar G$.*
>
> *Proof.* Suppose first that $X_1$ divides $\bar G$. Let $a=(p^j,1)$ with $j$ large. … So if $\bar G_a\neq0$,
> $\lambda(G_a)\ge p^j$. But $\bar G_a$ can vanish for only finitely many $j$. Conversely suppose that
> $X_1\nmid\bar G$. Then $\bar G(0,T)$ does not vanish identically; let $r$ be its $T$-order. A direct calculation
> shows that $\lambda(G_a)\le r$ on a neighborhood of $(0,1)$.

同 p.232 の Theorem 3.3 と p.233 の Theorem III は、これを加群・数体の側へ持ち上げたものである。

### 3.1 本文の $\theta$ との対応（これが同定の中身）

本文（命題 J）の設定は $\tilde E=\sum c_{pq}z^pw^q$、$A_m(a,b)=\sum c_{pq}\binom{pa+qb}{m}$、
$\theta(a,b)=\min\{m:\ell\nmid A_m(a,b)\}$ である。特殊化
$\varphi_a:\ z\mapsto(1+T)^{a},\ w\mapsto(1+T)^{b}$ の下で

$$\varphi_a(\tilde E)=\sum_{p,q}c_{pq}(1+T)^{pa+qb}=\sum_m A_m(a,b)\,T^m$$

だから、$\bmod\ \ell$ で見て

- $\theta(a,b)=\infty\iff$ すべての $m$ で $\ell\mid A_m(a,b)\iff\bar G_a=0$、
- $\theta(a,b)<\infty$ のとき $\theta(a,b)=\mathrm{ord}_T(\bar G_a)=\lambda(G_a)$

である（後者は $\mu(G_a)=0$ すなわち $\bar G_a\neq0$ の場合の $\lambda$ の定義そのもの）。
また $X_1\mid\bar G$ は方向 $(0{:}1)$ における $(\chi^{u^\perp}-1)\mid\bar{\tilde E}$ にあたる。

**「近傍で非有界」と「その点で $\infty$」が同値であること**は本文 (J1) から出る:

- $\theta(P)<\infty$ なら、$\ell^L\ge\theta(P)$ なる $L$ を取ると (J1) により $\theta$ は $P$ の
  $\bmod\ \ell^L$ 近傍で定数、とくに有界。
- $\theta(P)=\infty$ なら、任意の $L$ について $Q\equiv P\ (\mathrm{mod}\ \ell^L)$ が $\theta(Q)\le\ell^L$ を
  満たすことはない（もし満たせば (J1) により $\theta(P)=\theta(Q)<\infty$）。よって非有界。

**したがって (K2) の (i)⟺(iii) は Monsky Lemma 2.3（$d=2$）と同じ内容である。**
これは cycle 21 step 1 §13-3 が「未読なので判定できない」と隔離していた論点の、**片方の決着**である。

### 3.2 既出でない部分

Monsky が与えているのは「ある特定の方向 $(0,1)$ について、基底を取り替えて判定する」という形であって、
**どの方向が候補になるかを係数から列挙する手続きは無い**。本文 (K3) はそれを与える
（$S$ の 2 点差から高々 $\binom{|S|}{2}$ 個の候補を作り、各候補で $\mathbb{F}_\ell$ 上 $O(|S|^3)$ で判定）。
ただし **(K3) は本論文の命題 F（cycle 16、一般の $d$）の $d=2$ への特殊化**であり、
命題 F 自体も新規性を主張していない。**すなわち (K3) は文献に対しても自分自身に対しても新しくない。**

---

## 4. 定理 W4 の既出性 — **読んだ範囲には無い**

W4 は「$j^*(P)=m_u$（$\chi^{u^\perp}-1$ の重複度）」という**点ごとの等式**である。

- CM Definition 1.2 は $l_0$ を**重複度の総和**として定義するが、その総和を
  「$\ell$ 進近傍の変形から定まる $j^*$」と結びつける記述は無い（そもそも $j^*$ に当たる量が出てこない）。
- Monsky Lemma 2.3 の逆向き（$X_1\nmid\bar G$）は $\lambda(G_a)\le r$ という**上界**であって等式ではない。
  割り切れる場合（本文の $S_\infty$ の点）の $\lambda(G_a)$ の**値**は、同補題では
  「$\ge p^j$ で非有界」としか言われていない。
- CM §2–§7 は加群論（円分埋め込み・$\Lambda_d$ 加群・structures・Theorem I の証明・Theorem II・
  Greenberg 予想）であり、$l_0$ の**計算**には戻ってこない。$l_0$ が本文に現れるのは §1 と、
  §5 末尾（p.248）の「The invariants $m_0(L/k)$ and $l_0(L/k)$ were originally introduced in [1, 5].
  For further information about them … see [2,5].」という**参照指示だけ**である。

その参照先も辿った:

- **[5] Monsky, *Some invariants*** … 全文を読んだ（§3 のとおり）。
- **[2] Cuoco, Compositio Math. 41 (1980), 415–437** … PDF を取得し Introduction と Theorem 1.1 の周辺を読んだ。
  同論文が「precise description を与える」と書いているのは **$m_0$ であって $l_0$ ではない**
  （Theorem 1.1 は $\lambda_n=tp^n+c$, $\mu_n=m_0p^n+m_1n+c_1$ の形を与えるもの）。
- **[1] Cuoco, Brandeis Ph.D. thesis (1979)** … **取得も閲覧もしていない。したがって「そこに無い」とは書かない。**

**結論: W4 は読んだ範囲には無い。ただし「無い」と言えるのは上の 3 文献の読んだ範囲についてだけである。**

### 4.1 ついでに確認できたこと（$c,d,e$ の位置づけ）

CM §7 の Theorem 7.2 は「$M=\Lambda_d/(F)$ なら $e(M/I_nM)$ は大きな $n$ で $n$ と $p^n$ の多項式である」
と述べる（根拠は Monsky *On p-adic power series* の主定理）。本論文の $\Sigma_n$ はまさにこの型なので、
**閉形式の「存在」は 1981 年から既知**である。CM が明示的に同定している係数は $m_0$ と $l_0$ の 2 つだけで、
それ以外は Monsky 1981 p.227 Remark 2 の「The other coefficients remain mysterious」のままである。
これは本文（命題 W の既出性調査）が Monsky 1989 について書いていることと整合し、矛盾しない。

---

## 5. 本文へ何を書いたか（ブロック単位）

**本 step が触った本文ブロックは 2 つだけである。**

### 5.1 命題 K（`structured-latex/content/009_s_infinity_decision.ts` / 英語版同名ファイル、id `paper_101_theorem_s_infinity_decision`）

1. **(K6) の直後に段落を 1 つ追加**: 「(K6) は新しい主張ではない。$b$ は Cuoco–Monsky の $l_0$ と
   定義から一致し、(K6) の等式は Theorem 1.7 が与える $n\ell^n$ の係数そのものである。」
2. **「限界」の最後の項目（1 件）を 4 項目へ差し替え**:
   - (K6) が既出であること（Definition 1.2 の内容と、$\bar\sigma-1\leftrightarrow\chi^{v}-1$ の対応、
     Theorem 1.7 の式。命題 D が既に同定理を引用していることへの相互参照つき）。
   - (K2) の同値が既出であること（Monsky Lemma 2.3、$\theta=\lambda$ の対応、(J1) による
     「近傍で非有界 ⟺ その点で $\infty$」）。
   - **(K3)・(K4)・(K5)・(K7) は読んだ範囲に無いこと。読んだ範囲を頁つきで明示し、
     Cuoco の学位論文を読んでいないことを明記。** (K3) が命題 F の特殊化であることも書いた。
   - 群環の $(\chi^{v}-1)$ による分解が標準的な道具であること（元の文の残す価値のある部分）。

   差し替え前の文言は「対応する概念が既に導入されている可能性が高い。対応する文献命題は特定できていない。」
   であり、**いまや特定できたので、可能性の言及を事実の記述に置き換えた。**

### 5.2 命題 J（`content/008_theta_padic.ts`、id `paper_091_theorem_theta_padic`）

「限界」の最後の項目に 1 文を追加: **(J4) の係数 $b$ の式そのものは既出であり、出典は
Cuoco–Monsky Theorem 1.7 ＋ Definition 1.2 である**（詳細は命題 K の「限界」へ相互参照）。
$b$ の式が本文で最初に現れるのは命題 J なので、そこに帰属が無いのは読者に対して不正確である。

### 5.3 第 5 章の既存の引用との整合

命題 D（`content/005_duality.ts`）は既に Monsky Theorem 5.6 と Cuoco–Monsky Theorem 1.7 を引用し、
$m_0(f)=v_p(\mathrm{content}\,P)$ の言い換えも書いている。**そこへは触っていない。**
命題 K の新しい記述は「同定理は命題 D が既に引用している」と相互参照して重複を避けた。
命題 W（`006_propositions_TVW.ts`）の「$\mu$ の上界は Cuoco–Monsky Theorem 1.7 の帰結」という
既存の記述とも矛盾しない（あちらは $m_0$、こちらは $l_0$ で、同じ定理の別の係数である）。

### 5.4 触っていない本文

- `005c_ell2_family.ts` の「本命題の内容が Monsky / Cuoco–Monsky の枠組みで既に扱われている
  可能性は高い。**確認できていない。**」は**そのままにした。** 同命題は $\ell=2$ 族の $c,d,e$ まで
  含む閉形式であり、CM が同定している係数（$m_0$, $l_0$）の外側にある。§4.1 のとおり CM は
  そこを「mysterious」と書いているだけで、**「扱われていない」と断言する根拠は Cuoco の学位論文を
  読むまで得られない。** 現状の記述の方が正確である。
- `structured-latex/tools/` と `structured-latex-en/tools/` は step 2 の担当なので触っていない。
  **例外表（`ja-en-exceptions.ts`）へは 1 件も登録していない**（登録数は 11 件のまま）。

---

## 6. 転記事故の防止（cycle 18・20・21 で 3 回起きている型）

**根拠 report と機械的に突き合わせながら**書いた。突き合わせの内容:

| 書いた主張 | 突き合わせた一次情報 |
|---|---|
| $l_0$ の定義（$\bar F_0$ の $\bar\sigma-1$ 型既約因子を重複込みで数える） | CM p.237 Definition 1.2 の原文（cycle 16 の書き写し）と Monsky p.230 Definition 1.1(b) の**ページ画像を直読** |
| Theorem 1.7 の式 $\Sigma_n=(m_0p^n+l_0n+O(1))p^{(d-1)n}$ | 同上。**$d$ を残した一般形のまま**書いた（本文の $d=2$ の式へ勝手に潰していない） |
| Lemma 2.3 の主張 | Monsky p.231 の**ページ画像を直読**。$\bar G$ のバー、$\lambda(G_a)$ と $\bar G_a$ の区別、$\le r$（$<r$ ではない）を確認 |
| $\theta=\lambda$ の対応 | 本文（命題 J）の $A_m$ の定義から自分で導出し、§3.1 に導出を残した |
| 「近傍で非有界 ⟺ その点で $\infty$」 | 本文 (J1) から導出。**(J1) を仮定なしに使えることを確認**（(J1) には $A_1\equiv0$ の仮定があるが、これは命題 G (G6) から無条件に従う） |

**仮定の脱落チェック**: 書き足した文のうち、仮定を持つのは (K6) の既出性の主張だけである。
CM Theorem 1.7 は $F\neq0$ 以外の仮定を持たない。**本文の (K6) の方が仮定が多い**
（$\hat\theta$ の最小点の一意性を引き継ぐ）ので、「既出である」という向きの主張に仮定の脱落は起こりえない。
なお cycle 21 step 1 の定理 Q1 はその仮定を落としており、そこで既出定理と完全に一致する。

---

## 7. 検証（内訳つき）

すべて worktree 内で前景実行。**Node は 22.22.3、依存は worktree に無かったので `pnpm install` した**
（worktree では gitignore された依存が存在しないのが正常な初期状態）。

| コマンド | 結果 | 内訳 |
|---|---|---|
| `(cd structured-latex && npm run check)` | **exit 0** | 生成物の鮮度 OK／型検査 OK／`validate` 43 ブロック・34 ラベル・89 参照すべて解決／`build-latex` OK／負テスト 9 件・実行時検証テスト 13 件すべて期待どおり |
| `node structured-latex/tools/validate-content.ts` | **exit 0** | 43 ブロック（12 ファイル、11 見出し、34 ラベル、89 参照、すべて解決）／ノート 0 件／SageMath 42 件・Lean 67 件すべて実在／ℝ 脱出宣言 6 件 |
| `(cd structured-latex-en && npm run check:full)` | **exit 0** | 型検査・`validate`（50 ブロック、40 ラベル、91 参照、**55 引用**、すべて解決）・`build-latex`・負テスト・実行時検証テスト 11 件／**`verify:correspondence` 違反 0 件**（対応 43 件、欠落ブロック 0、欠落ラベル 0、英語版限定 7、**例外表 11 件のまま増やしていない**） |
| `node sagemath/tools/verify-check-linkage.ts` | **exit 0** | 43 ブロック中 23 が verification を持ち、35/44 の検証ディレクトリが参照されている。**孤立 9 件**（うち `cycle21_T3_b_star` と `cycle21_T3_general_closed_form` は cycle 21 の成果で、本文からまだ参照されていない。**本 step の変更で増えたものではない**） |
| **自前の日英数式多重集合の突き合わせ** | 命題 K は差 **3 件**、命題 J は差 **0 件** | 下記 §7.1 |

### 7.1 例外表が開けている穴を自分で塞いだ（cycle 21 step 4 の事故と同型の検査）

**命題 K（`paper_101_theorem_s_infinity_decision`）は数式差の例外表に登録済みである。**
つまり `verify:correspondence` はこのブロックの数式多重集合を**一切見ない**。
cycle 21 step 4 で英語版のインライン数式 11 個が落ちたのはまさにこの穴である。
そこで**呼び出し元と同じ手で、全 43 ブロックについて数式多重集合を独立に突き合わせた**
（`math` / `displayMath` の `tex` を空白正規化してソート、差分を両方向で列挙）。

結果:

- **命題 K: ja 122 個 / en 122 個。差は 3 件**で、いずれも `\text{}` の中身の翻訳
  （「原始」→ "primitive"、「〜の原始二項式部分の次数」→ "the degree of the primitive binomial part of"、
  「したがって」→ "hence"）。**登録されている例外理由そのものであり、訳し落としではない。**
- **命題 J: ja 125 個 / en 125 個、差 0 件。**
- 全ブロックでは差のあるブロックが 11 件で、**すべて**例外表に登録済みの 2 種類
  （`\text{}` の中身の翻訳／リポジトリ内部パスの削除）に該当した。**説明のつかない差は 0 件。**

### 7.2 この検査が実際に見つけた既存の不備（1 件）

最初の突き合わせで、命題 K に**説明のつかない差が 2 件**出た。内訳を見て正体を特定した。

1. **日本語版だけに `\ell` が 1 個**。追ってみると、(K4) の解説で日本語正本が
   「$j^*$（**$\ell$ 進**近傍の変形から定まる量）」と書いているのに対し、英語版は
   地の文で "a deformation in a **p**-adic neighbourhood" と書いていた。
   **本論文で $p$ は Cuoco–Monsky 側の素数、$\ell$ は塔の素数であり、両者を混ぜてはならない。**
   これは cycle 21 step 4 で英語版を書いた際に混入したもので、例外表のせいで検査を素通りしていた。
   地の文の "p" をやめ、$\ell$ の数式ノードを使う形へ修正した。
2. **日本語版だけに `\mathbb{Z}_p^d` が 1 個**。これは本 step が書き足した文で、日本語版が
   Monsky の論文名を地の文（数式込み）で書き、英語版が `cite` ノードで済ませていたためである。
   英語版でも論文名を数式込みで書く形へ揃えた。**自分が作った差である。**

1 は既存の不備、2 は自分の不備である。どちらも `verify:correspondence` では検出されなかった。

---

## 8. 自分が犯した誤り（隠さず記録する）

1. **強調記号がノードをまたぐ書き方をした（日英とも、計 4 箇所）。** `**…**` を
   「文字列ノード → 数式ノード → 文字列ノード」にまたがって書いたため、
   `build-latex.ts` の「対応の取れない `**` が地の文にある」検査でビルドが落ちた。
   **落ちてくれたので直せた**（PDF にアスタリスクがそのまま出る事故の手前で止まった）。
   強調を 1 ノードの中で閉じる形へ書き直した。
2. **上記 7.2-2 の日英差**。英語版で書誌を `cite` に任せた結果、日本語版にだけ数式が残った。
   **例外表に登録されているブロックだったので、公式の検査では見つからなかった。**
   自前の突き合わせを回していなければ、そのまま push していた。
3. **Cuoco 1980 の表題を References から写しかけた。** CM と Monsky の References はどちらも
   "The growth of **Iwasawa's** invariants in a family" と書いているが、
   **論文自身の扉は "The growth of Iwasawa invariants in a family"** である（NUMDAM の PDF で確認）。
   論文自身の綴りを採り、`refs.bib` の note に食い違いを明記した。
4. **`npm` が PATH に無いのを「環境が壊れている」と読みかけた。** 実際は nvm 管理下
   （`~/.nvm/versions/node/v22.22.3/bin`）にあるだけで、worktree に依存が無いのと合わせて
   **どちらも正常な初期状態**だった。`pnpm install` して進めた。

---

## 9. 書誌データの更新（`outputs/papers/001_R_Lambda_duality/refs.bib`）

- **`MonskySomeInvariants1981`** … 「本文で引用していない控え」から**本文が引用するもの**へ。
  何を確認して引用したか（Lemma 2.3、p.231）を note に書いた。
- **`Cuoco1980`（新規）** … Compositio Math. **41**(3), 415–437 (1980)。NUMDAM の URL つき
  （**DOI は付与されていない**ので書いていない）。読んだ範囲と、表題の綴りの食い違いを note に書いた。
- **`CuocoMonsky1981`** … note の「§3–§7 は未読」を「本 step で pp.235–258 の全ページを通読した」へ更新。
- 冒頭の「本文が cite しているもの／控え」の対応表を引き直した（18 件 → 20 件、控え 5 件 → 4 件）。

---

## 10. 残ったこと（次に何が妨げているか）

1. **Cuoco の学位論文（Brandeis, 1979）が未取得。** CM p.248 が $l_0$ の出所として挙げる 2 件のうち
   1 件である。ProQuest 等の学位論文データベースが要り、無料公開されているかは未確認。
   **これを読まない限り、(K3)・(K4) について「文献に無い」と言い切ることはできない。**
   本文にもその旨を書いた。
2. **CM Theorem 1.7 の証明（Lemma 1.4/1.5/1.6 と、それが依拠する Monsky *On p-adic power series*
   の Theorem 2.1–2.9）は読んでいない。** したがって cycle 21 step 1 の §3–§6 の初等証明が
   CM の証明と同じものかは**依然として判定していない**（cycle 21 §11 の未確認事項がそのまま残る）。
   本 step の課題は既出性の判定であって証明の異同ではないので、ここは埋めていない。
3. **孤立している検証ディレクトリ 2 件**（`cycle21_T3_b_star`, `cycle21_T3_general_closed_form`）。
   cycle 21 の成果に対応する本文ブロックが `verification` を張っていない。
   本 step は帰属の書き足しに範囲を絞ったので触っていない。
