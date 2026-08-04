# cycle 28 step 1: 未着手だった命題 W* と命題 F に着手した（全数形式化の最優先分）

変更: `lean/IntegrableLattice/PropWStarDifferent.lean`（新設・**6 宣言**）、
`lean/IntegrableLattice/PropFFiniteSupport.lean`（新設・**8 宣言**）、
`lean/IntegrableLattice.lean`（2 モジュールの import）、
`lean/scripts/check-no-sorry.sh`（対象へ 14 件追加。357 → **371**）、
`lean/README.md`（命題ごとの表へ 2 行追加、被覆の数値を更新）、
`structured-latex/tools/formalization-coverage.ts`（2 件を 未着手 → 部分的）、
本文 `content/{004_lambda_finite,005_duality,007_asymmetry_scope}.ts` と英語ロケール同名 3 ファイル
（`lean` の紐づけ追加と、**被覆の数値の更新だけ**。数学の文言は 1 文字も変えていない）。

## 対象の選び方（ユーザー方針に従う）

2026-08-03 のユーザー方針は「論文の主張を全数 Lean 形式化することを目標にする」であり、
着手順は「mathlib の欠落が無いもの」からと定めてある。着手時の実測（検査 F の実出力）は

> 主張 24 件 / 完了 5・部分的 14・未着手 5 / 残り 19 件

で、**未着手 5 件のうち mathlib の欠落が理由なのは 3 件**（命題 LSW と双対命題 D が多変数の
Mahler 測度、命題 G が matrix-tree 定理）。残る 2 件が本 step の対象である。

なお、台帳が命題 W* に書いていた理由は「mathlib に different は在るが本文の経路へ配線されておらず、
**どの段で詰まるかをまだ一次情報で特定していない。まず調査から要る**」だった。
**「すぐ着手できる」は「調査が要らない」という意味ではない。** 実際、本 step の作業の半分は
命題 W* を段に分けて、どの段が mathlib の欠落に当たり、どの段が当たらないかを分けることだった。

## 命題 W*: 3 段のうち 2 段が入った

命題 W* は 3 つの段からできている。

1. **微分の段** — $\chi=\prod_i f_i^{a_i}$、$\rho=\mathrm{rad}(\chi)$、$h=\chi/\rho$ のとき
   $\chi'/h=\sum_i a_i f_i'(\rho/f_i)$、とくに $\chi'/h\in\mathbb{Z}[x]$。
2. **双対の段** — $\rho$ が分離的なら $A^\vee=\rho'(\theta)^{-1}A$（Euler の双対基底公式）、
   ゆえに $\operatorname{coker}(G)\cong A/\eta A$ で、$G$ の単因子は $A/\eta A$ の不変量に等しい。
3. **付値の段** — $A$ が $p$ 極大なら $p^j\eta^{-1}\in A_{(p)}$ は各 $\mathfrak p\mid p$ で
   $j\,e_\mathfrak p\ge v_\mathfrak p(\eta)$ と同値で、最小の $j$ が
   $\max_\mathfrak p\lceil v_\mathfrak p(\eta)/e_\mathfrak p\rceil$。

**入ったのは 1 と 3 である。2 は入っていない。**

### 微分の段: 既約性も相異性も要らなかった（過剰仮定 1 件）

本文は $f_i$ を「$\chi$ の相異なる既約因子」として導入する。ところが恒等式

$$\mathrm{derivative}\Bigl(\prod_{i\in s} f_i^{a_i}\Bigr)
  = \Bigl(\prod_{i\in s} f_i^{a_i-1}\Bigr)\cdot\sum_{i\in s} a_i\,f_i'\prod_{j\in s\setminus\{i\}} f_j$$

そのものは**任意の可換環の任意の族**で成り立つ（`derivative_prod_pow`）。
効いているのは $a_i\ge1$ だけである。既約性・相異性が要るのは $\rho$ を $\mathrm{rad}(\chi)$ と
名乗る段と $\rho$ の分離性であって、恒等式の段ではない。
**仮定は主張が要求したものではなく、文脈が要求したものである**
（cycle 27 step 2 が `PropC.lean` の持ち上げ補題で見たのと同じ形。2 サイクル連続で同じ形が出た）。

**割り算を型に出さずに済ませた。** 本文は $\chi'/h$ と書くが、Lean では
$\chi'=h\cdot(\text{多項式})$ の形で述べた。この形で述べれば「$\chi'/h$ が多項式である」は
言えており、商体へ出る必要が無い。

### 付値の段: 本文の但し書きが型でそのまま出た

本文は
「この式の切り上げは実数の切り上げではない。$v_\mathfrak p(\eta)$ と $e_\mathfrak p$ はどちらも整数なので、
整数の商の切り上げであり、整数の除算ひとつで決まる。実対数も実数の演算も現れない」
と書いている。これは Lean で**そのまま型になる**——`ceilDivNat v e := (v + e - 1) / e` は
$\mathbb{N}$ の除算ひとつで、$w^*$ は `Finset.sup` で $\mathbb{N}$ の元である。
**ファイル全体に `Real` が 1 度も現れない**（`grep` で確認）。

形式化したのは次の 4 つ。

- `ceilDivNat_le_iff` — $e\ge1$ なら $\lceil v/e\rceil\le j\iff v\le j\,e$（2 つの読みを結ぶ一点）。
- `isLeast_wStar` — $\min\{j:\forall\mathfrak p\in s,\ v_\mathfrak p\le j\,e_\mathfrak p\}
  =\max_{\mathfrak p\in s}\lceil v_\mathfrak p/e_\mathfrak p\rceil$（`IsLeast` で最小性ごと）。
- `wStar_eq_zero_of_unramified` — 不分岐かつ $p\nmid a$ なら $w^*=0$（本文の但し書き）。
- `wStar_le_of_tame` — 従順分岐（$d_\mathfrak p<e_\mathfrak p$）なら $w^*\le v_p(a)+1$（同）。

### 双対の段が残る理由（一次情報。「難しそう」とは書かない）

`PropCTracePeriod.lean` が cycle 19 に一次情報で特定した内容がそのまま当てはまる。
mathlib には `Mathlib/RingTheory/DedekindDomain/Different.lean` に
`traceDual`・`differentIdeal`・`aeval_derivative_mem_differentIdeal`・`conductor_mul_differentIdeal` が
**在る**（`logs/mathlib-gap-survey-cycle19.log`）。無いのは 2 つ。

- 重み付きトレース形式 $\langle x,y\rangle=\operatorname{Tr}(\mu xy)$ の Gram 行列の
  **最大単因子**へ結ぶ配線。
- **整数行列の Smith 標準形**。`Basis.SmithNormalForm` は部分加群の基底の形で与えられており、
  行列の単因子の形では与えられていない。

## 命題 F: (F1) の心臓部が入った

命題 F の (F1) が主張しているのは、素イデアル $(\gamma_v-1)$ の添字集合
$\mathbb{P}^{d-1}(\mathbb{Z}_p)$ が**非可算であるにもかかわらず**、$\bar P$ を割りうるものは
**有限個の有理方向に限られる**ことである。本プロジェクトの用語で言えば、
非可算側を走らずに済むという主張であり、計算可能性の中身はここにある。

人手証明はこれを次の一点で出している——各 $c_e\ne0$ なので、割るためには
**どのファイバーも 2 点以上でなければならない**。形式化したのはこの一点である。

- `exists_ne_of_fibers_sum_eq_zero` — すべてのファイバーの係数和が消えるなら、
  分類写像は台の上で単射でない（したがって $\pi(e)=\pi(e')$ なる $e\ne e'$ が在る）。
- `vecGcd` / `prim` / `isUnit_vecGcd_prim` — 原始化と、方向が**単元倍を除いて**一意なこと。
  単元倍まででよいのは、本文が決めているのが直線 $\mathbb{Z}_p v$ だからである。
- `directions` / `mem_directions_of_fibers_sum_eq_zero` — 割りうる方向は有限集合
  $V(E)=\{\mathrm{prim}(e-e'):e\ne e'\in E\}$ に入る。
  $V(E)$ は `E` から作れる `Finset` である。

**過剰仮定 1 件**: この段に体であることも標数 $p$ であることも要らない。
必要なのは「$c_e\ne0$」と「和が 0」だけなので、係数は任意の可換群でよい。
本文が $\mathbb{F}_p$ で書いているのは文脈がそうだからであって、この段が要求しているからではない。

**内容があるのは包含のほうである。** $V(E)$ が有限なのは $E$ が有限だから自明で、
主張の中身は「割りうる方向がそこから出られない」である。

### 残る 2 つと、その理由の区別

- $(\gamma_v-1)\mid\bar f\iff\forall a\in\pi(E):\sum_{\pi(e)=a}c_e=0$ という**同値そのもの**。
  $d$ 変数の完備群環 $\mathbb{F}_p[[\Gamma]]$ とその素イデアルの記述が要る。
  mathlib には岩澤代数の一般論が `PowerSeries` と位相代数の断片としてしか無く、
  **配線ではなく素材から要る**。
- **(F2 境界)**（$d\ge2$ で $l_0(f)\ge1$ が停止問題へ帰着する）。
  `Nat.Partrec` / `Turing` は**在る**が、「係数を計算する手続きで与えられた $f$」という
  **入力の与え方**を型にする設計をこちらが持っていない。
  **これは mathlib の欠落ではなく、こちらの未設計である**（区別して書く）。

## 被覆の変化（誇張しないための注記）

| | 着手前 | 着手後 |
|---|---|---|
| 完了 | 5 | 5 |
| 部分的 | 14 | **16** |
| 未着手 | 5 | **3** |
| **全数まで残り** | **19** | **19** |

**残りは 19 件のまま変わっていない。** 残りとは「完了でないもの」の数であり、
本 step が動かした 2 件はまだ完了ではないからである。
**動いたのは「未着手か部分的か」であって、全数への距離ではない。**
本文の数（24 件中 5・14・5）は古くなったので日英とも更新した
（この数と台帳が一致することを検査にするかは本サイクル step 6 の対象）。

## 検証

- `lake build` — 8683 jobs、exit 0。
- `scripts/check-no-sorry.sh` — **371 定理**（着手前 357）すべて sorryAx 非依存、exit 0。
- 新規 2 ファイルに `Real` の使用 **0 件**（`grep`）。
- `npm run check`（25 段）exit 0、`build:pdf` 日 50 頁・英 64 頁。

## 自分の誤りの記録

1. **`R[X]` を `open Polynomial` 無しで書き、配列の添字として解釈された。**
   エラーは「index is valid であることを証明できない」という一見無関係なもので、
   原因が記法の未 open だと分かるまで 1 往復かかった。
2. **`Finset.sup_eq_bot_iff` を実在を確かめずに書いた。** 存在しなかった。
   **cycle 26 step 6 に記録され cycle 27 step 2 で再発した「実在を確かめずに mathlib の補題名を書く」の
   3 サイクル連続の再発である。** 本 step でも同じことをした。
   使う前に `grep` する手順を実際に踏んだのは、この失敗のあとの `Nat.div_lt_iff_lt_mul` からだった。
3. **`Finset.erase_insert_of_ne` の引数の向きを取り違えた**（`i ≠ x` を渡したが要るのは `x ≠ i`）。
   宣言を読まずに使用例から推測したのが原因で、これも 2 の同型である。
4. **`congr 1` が何を残すかを確かめずに `omega` を置いた。** 落ちた。
   等式を `have` で先に用意して `rw` する形へ書き換えたら通った。
   **「タクティクがこう振る舞うはず」を根拠にしない**という点で、
   cycle 27 の「`omega` が非線形を閉じると決めつける」と同じ形である。

## 限界

- **入ったのは 2 命題とも「一部」である。** 命題 W* の中核である双対の段（単因子と差積の同一視）と、
  命題 F の中核である割り切れ判定の同値は、どちらも入っていない。
  「命題 W* と命題 F に着手した」は「両命題を形式化した」の意味ではない。
- 命題 F の `exists_ne_of_fibers_sum_eq_zero` は、台が 1 点のときは仮定が矛盾する
  （$c_{e_0}=0$ と $c_{e_0}\ne0$）ので結論が矛盾から出る。数学的には正しいが、
  **この場合に検査としての力は無い**。力があるのは台が 2 点以上のときである。
- 過剰仮定の指摘 2 件は、いずれも**本文の主張の誤りではない**。文脈がその仮定を満たしているので、
  本文は直していない（cycle 27 step 2 の `PropC.lean` と同じ扱い）。
