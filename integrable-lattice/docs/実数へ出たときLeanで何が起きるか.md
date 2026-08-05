# 実数へ出たとき Lean で何が起きるか（形式化の線引きを決めるための実測）

この文書は、**形式化する／しないの線引きを何に置くべきか**を判断するための材料である。
**どの基準を採るかはここでは決めない。** それはユーザーの価値判断だからである。

出発点は次の疑問である。現行の[外部定理の振り分け基準](external-theorem-criterion.md)は
「$\mathbb{R}$ 脱出として隔離する」という枠を持ち、**実数へ出るかどうかを
形式化する／しないの境目に使っている**。これに対し、境目にするなら
「あまりに一般的すぎて形式化すると冗長になるもの」だけを外すのがイメージであり、
そもそも非可算の世界へ行くと Lean 上で何が起きるのかが把握されていない、という疑問である。

以下はすべて一次情報（mathlib の宣言の直読、`#print axioms` の実行出力、リポジトリ内のファイル）による。

## 測定環境

| 項目 | 値 |
| --- | --- |
| Lean toolchain | `leanprover/lean4:v4.32.1`（`lean/lean-toolchain`） |
| mathlib | `520045ab14e26149ee970e2e617ca04b09bde5d6`（`lean/lake-manifest.json` の固定 rev） |
| mathlib 走査対象 | `Mathlib/**/*.lean` 8264 ファイル |

## 実数を Lean で扱うと、具体的に何ができなくなるのか

### 決定可能性と計算 — `decide` が使えなくなり、`#eval` は値を返さなくなる

**実数の等号・順序の判定は、mathlib では算法ではない。**
判定手続きを与える代わりに、選択公理でその存在だけを言っている。宣言を直読すると、

```
Mathlib/Data/Real/Basic.lean:489:  open scoped Classical in
Mathlib/Data/Real/Basic.lean:490:  noncomputable instance linearOrder : LinearOrder ℝ :=
Mathlib/Data/Real/Basic.lean:491:    Lattice.toLinearOrder ℝ
Mathlib/Data/Real/Basic.lean:520:  noncomputable instance decidableLT (a b : ℝ) : Decidable (a < b) := by infer_instance
Mathlib/Data/Real/Basic.lean:522:  noncomputable instance decidableLE (a b : ℝ) : Decidable (a ≤ b) := by infer_instance
Mathlib/Data/Real/Basic.lean:524:  noncomputable instance decidableEq (a b : ℝ) : Decidable (a = b) := by infer_instance
```

`noncomputable` が付いており、中身は `Classical` を開いた `LinearOrder ℝ` から拾ってくる。
実際に依存公理を取ると（実行結果）、

```
'Real.decidableEq' depends on axioms: [propext, Classical.choice, Quot.sound]
'Real.decidableLT' depends on axioms: [propext, Classical.choice, Quot.sound]
```

対して $\mathbb{N}$ と $\mathbb{Q}$ の判定は**公理をひとつも使わない実際の算法**である。

```
'Nat.decEq' does not depend on any axioms
'instDecidableEqRat' does not depend on any axioms
'Rat.instDecidableLt' does not depend on any axioms
```

（`Nat.decEq` の実体は `Init/Prelude.lean:1855` の `beq` による場合分けである。）

この差は `decide` の可否として現れる。`(2:ℕ) < 3`・`(2:ℚ) < 3`・`(2:ℚ) = 2` はいずれも
`by decide` で通り、**`(2:ℝ) < 3` も `(2:ℝ) = 2` も通らない**。Lean のエラーはその理由まで書く。

```
error: Tactic `decide` failed for proposition
  2 = 2
because its `Decidable` instance
  Real.decidableEq 2 2
did not reduce to `isTrue` or `isFalse`.
Hint: Reduction got stuck on `Classical.choice`, which indicates that a `Decidable` instance is
defined using classical reasoning, proving an instance exists rather than giving a concrete
construction. （以下略）
```

`#eval` はエラーにはならないが、値を返さない。`#eval (2:ℕ) + 3` と `#eval (2:ℚ) + 3` は
どちらも `5` を返し、`#eval (2:ℝ) + 3` が返すのは次である。

```
Real.ofCauchy (sorry /- 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, ... -/)
```

すなわち Cauchy 列の代表を延々と刻んで見せるだけで、**等しいかどうかを判定できる対象は出てこない。**

もう一つ、実務上いちばん厄介な形で現れるのが**ジャンク値**である。mathlib の実対数は
定義域の外でも値を返す。

```
Mathlib/Analysis/SpecialFunctions/Log/Basic.lean:44:  noncomputable def log (x : ℝ) : ℝ :=
Mathlib/Analysis/SpecialFunctions/Log/Basic.lean:45:    if hx : x = 0 then 0 else expOrderIso.symm ⟨|x|, abs_pos.2 hx⟩
```

`Real.log 0 = 0` である（`log_zero`、同 102 行）。**これは間違いではないが、
定義が壊れている場合に式が黙って「動いてしまう」ことを意味する。**
このプロジェクトで実際に起きた（`Cycle24Corrections.lean` の `Q5_logb_junk_at_b_zero`、
`Cycle25Corrections.lean` の `Q5_old_logb_value_at_b_zero`）。
$c_1=\max(0,\lceil 1+\log_\ell\frac{2b}{\ell-1}\rceil)$ という実対数による定義は $b=0$ で
真数が $0$ になり本来定義されないのに、ジャンク値のおかげで $1$ を返す。
**その $1$ には数学的な根拠が無い。** $c_1$ を「$2b<(\ell-1)\ell^{c}$ を満たす最小の $c$」
という $\mathbb{N}$ 上の決定可能な述語で取り直したら、実対数も切り上げも要らなくなり、
$b=0$ の縮退も消えた（`Q5_c1_nat_least`・`Q5_c1_zero_b`）。

**四層の検証（[証明の書き方](../../docs/context/証明の書き方.md)）のうち、失われるのはどこか。**

| 層 | 実数へ出ると | 根拠 |
| --- | --- | --- |
| 記述 | 変わらない | 人が読む層である |
| SageMath で式変形を一行ずつ | **厳密計算が浮動小数点へ落ちる** | `sagemath/check/` の 47 ディレクトリのうち、浮動小数点を計算に使う（`RR`・`RealField`・`CC`・`CDF`、または実対数を `float` で取る）のは 8 で、いずれも Mahler 測度・全域木エントロピー・臨界点・アルキメデス側の誤差評価である。ほかに 2 つが `float()` を使うが、これは厳密に求めた $\mathbb{Q}$ の値を桁を切って表示するだけである（`RDF` と `.n()` はこのリポジトリに 1 度も現れない） |
| Lean 具体版 | **`decide` による自動検算ができなくなる。証明の検査は変わらない** | 上の実測。なお `by decide` はこのプロジェクトの Lean に 49 行・69 箇所あり、**そのどの行にも $\mathbb{R}$/$\mathbb{C}$ は現れない**（全数検査した）。実数に対する `decide` は上のとおり通らないので、これは当然である |
| Lean 必要十分版 | 変わらない | 仮定の削り方の問題であって決定可能性の問題ではない |

**要点は「証明できなくなる」ではなく「計算で裏を取る道が閉じる」である。**
決定可能性が効いているのは SageMath の厳密計算と Lean の `decide` であって、Lean の証明検査ではない。

### 公理 — 実数を使う定理と使わない定理で、依存公理は変わらない

**これは実測で確かめた。結論から書くと、変わらない。**

`lean/scripts/check-no-sorry.sh` を再実行し（`lake build` は 8731 ジョブ成功、
検査は終了コード 0）、列挙されている **785 定理の依存公理を全数**取った。分布は次のとおり。

| 依存公理 | 件数 |
| --- | --- |
| `propext`, `Classical.choice`, `Quot.sound` | 651 |
| `propext`, `Quot.sound` | 77 |
| `propext` のみ | 43 |
| `Quot.sound` のみ | 2 |
| 公理に依存しない | 12 |

**実数を使うかどうかで切っても、分布はほとんど変わらない。**
$\mathbb{R}/\mathbb{C}$ を使う 3 ファイルで宣言された 68 件のうち 3 公理すべてに依存するのは
53 件（78%）、それ以外の 713 件では 597 件（84%）で、**実数側のほうがむしろ低い**
（名前空間まで見て 785 件中 781 件を宣言のあるファイルへ対応づけた。
残る 4 件は宣言の書き方が機械的に拾えなかったので集計から外した）。

対にして並べると、何が公理を増やしているのかが見える。

| 定理 | 実数を使うか | 依存公理 |
| --- | --- | --- |
| `KirchhoffCounting.det_mul_transpose_eq_card_spanning`（matrix-tree の本体） | 使わない（$\mathbb{Z}$） | 3 公理すべて |
| `NewtonPolytope.newt_mul`（Newton 多面体の加法性） | 使わない（$\mathbb{Z}\times\mathbb{Z}$・$\mathbb{Q}$） | 3 公理すべて |
| `padicValNat_pow_sub_one_of_dvd`（命題 L の LTE） | 使わない（$\mathbb{N}$） | 3 公理すべて |
| `crudeBound_padicValInt_le_mul_logb`（補題 Q0 の実対数版） | **使う** | 3 公理すべて |
| `crudeBound_pow_padicValInt_le_natAbs`（同じ内容の $\mathbb{N}$ 版） | 使わない | 3 公理すべて |
| `Cycle24.Q5_c1_strict_of_logb`（補題 Q5 の実対数版） | **使う** | 3 公理すべて |
| `Cycle24.Q5_c1_nat_least`（同じ内容の $\mathbb{N}$ 版） | 使わない | `propext`・`Quot.sound` |
| `Cycle25.Q5_c1_table_check`（表 8 件を `by decide` で検算） | 使わない | `propext` のみ |

**すなわち `Classical.choice` は実数に特有ではない。** mathlib の補題はほとんどが古典論理で
書かれているので、$\mathbb{N}$ の中だけで閉じた主張でも、そうした補題を一つ引いた時点で
同じ 3 公理に依存する。逆に、公理が減るのは「実数を使っていないから」ではなく
「証明が軽く、古典的な補題を経由していないから」である。

**したがって「実数を使うと Lean の証明が余計な公理を要求する」という筋の心配は、実測では成り立たない。**

### 証明の手間 — 正しさの問題ではなく量の問題である

実数側の主張を形式化するのに要るのは、極限・位相・測度といった素材の積み上げである。
これは**書く量**の話であって、書いたものの正しさの話ではない。
ただしこのプロジェクトの実測では、量の問題が次の形で顔を出している。

- **可算側の主張なのに、標準的な証明経路が実数の位相を要求する。**
  Newton 多面体の加法性は指数が $\mathbb{Z}\times\mathbb{Z}$ に住む可算側の主張だが、
  頂点を取り出す標準の道（超平面による分離、Krein–Milman）は mathlib では $\mathbb{R}$ の
  位相を要求する。使えば主張は可算側にあるのに証明が実数へ出る。
  そこで分離定理を使わない道（「頂点でない点は中点として書ける」という組合せの事実）を取り、
  凸包を $\mathbb{Q}$ 係数で取ることで実数へ一度も出さずに書けた
  （`NewtonPolytopeAdditivity.lean`。台帳の当該欄が「設計の結果であって偶然ではない」と記録している）。
- **実数へ出たと思っていた箇所が、書き換えると出ていなかった。**
  補題 Q0（アルキメデス粗上界）は $\mathbb{C}$ の絶対値を使う段が本体だが、
  最後の実対数は $\ell^{v_\ell(N)}\le|N|$ という $\mathbb{N}$ の不等式を書き換えているだけで、
  脱出の原因ではなかった（`CrudeArchimedeanBound.lean` の冒頭コメントと
  `crudeBound_pow_padicValInt_le_natAbs`）。
- **「素材が無いから書けない」という事前判定が、着手すると何度も覆っている。**
  可換環上の Euler の双対基底公式は cycle 30 以降「素材が無い」と記録され続けたが、
  $\rho'(\theta)$ で割らずに書けば分離性も体も要らず、cycle 35–36 で完了した。
  Monsky の定理は cycle 29・31 の走査で 0 件だったが、cycle 40 に engine の側から引き直すと
  Weierstrass 準備定理が在った（「定理の名前で引くと、その定理を証明する道具が在っても見えない」）。
  **手間の事前見積もりは、この台帳の履歴上あてにならない。**

### 検証の強さ — 弱くならない

**このプロジェクトの検査が実際に確かめているのは 2 つだけである**
（`lean/scripts/check-no-sorry.sh` を直読した）。

1. ソース中に `sorry` / `admit` が残っていないこと（`grep`）。
2. `targets` に列挙した定理の `#print axioms` に **`sorryAx` が現れない**こと。

`grep -q 'sorryAx'` の一点だけを見ており、`propext` / `Classical.choice` / `Quot.sound` は
検査していない（`lean/README.md` も「mathlib 標準の 3 公理で問題ない」と明記している）。
`targets` は現在 785 件である。

**したがって、実数を使った Lean の証明は、使わない証明と比べて機械検証として弱くならない。**
Lean の kernel はどちらも同じ規則で検査し、この検査もどちらも同じ基準で通す。
実数を使うことで落ちるのは、上に書いた**計算による裏取り**の側だけである。

なおこの検査の射程には、実数と無関係な限界がある。`targets` は手で列挙する配列なので、
**列挙し忘れた定理は検査されない**。これも実数の有無とは無関係である。

## 現状の実測: このプロジェクトの Lean はどれだけ実数を使っているか

`lean/IntegrableLattice/` は 75 ファイル・18175 行。このうち
**$\mathbb{R}$ または $\mathbb{C}$ を型・項として使っているのは 3 ファイルだけである。**

| ファイル | 何のために使っているか | $\mathbb{R}/\mathbb{C}$ を含むコード行 |
| --- | --- | --- |
| `CrudeArchimedeanBound.lean` | 補題 Q0（アルキメデス粗上界）。1 の冪根の一次結合の複素絶対値で整数 $N$ を押さえ、$v_\ell(N)$ の上界を出す段。**この $\mathbb{C}$ が本物の脱出**で、末尾の `Real.logb` は $\mathbb{N}$ の不等式の言い換え | 23 |
| `Cycle24Corrections.lean` | 補題 Q5 の $c_1$ の旧定義（実対数による）の検算と、**その実対数が除去できることの証明**、およびジャンク値による縮退の記録 | 17 |
| `Cycle25Corrections.lean` | 訂正後の $c_1$（$\mathbb{N}$ 上の最小元）と旧定義の比較、命題 M の $\lambda=\lceil\log_\ell(e+1)\rceil$ の照合 | 22 |

残る 72 ファイルには $\mathbb{R}$ も $\mathbb{C}$ もコードとして現れない
（$\mathbb{R}$ の記号が出るのは `Cycle26ProofSteps.lean` の冒頭コメント 1 行だけである）。
`Cycle26ProofSteps.lean` と `Cycle27ProofSteps.lean` は冒頭に「`Real` を 1 つも使わない」と
明記してある（前者はさらに、本文が「$\mathbb{R}$ 脱出は命題 Q の (Q4) ただ 1 箇所」と
宣言していることとの整合を理由に挙げている）。

**論文本体の側も同じ形である。** `structured-latex/content/` の主張ブロックのうち
`habitat: "R"` を宣言しているのは **36 件中 2 件**で、いずれも第 3 章
（見出しが「アルキメデス素点側（既知）— ここだけが $\mathbb{R}$ を使う」）にある。

**つまりこのプロジェクトでは、実数はすでにほぼ使われていない。**
線引きをどこに置くかで動く対象は、後述するとおり数件である。

## 基準の選択肢

現在の台帳（`structured-latex/tools/external-theorem-coverage.ts`）は 27 件で、
内訳は **自分で証明する 7 / mathlib から引く 7 / $\mathbb{R}$ 脱出として隔離する 2 / 対象外 11**。
「自分で証明する」7 件の状態は 完了 4・部分的 1・未着手 2 である。

以下、それぞれの案を実際に 27 件へ当てはめる。

### 現行案 — 実数へ出るかどうかで分ける

現行基準は三条件（① 本文が証明の根拠として引いている、② 可算側の内容を担う、
③ mathlib に無い）で分け、① を満たすが ② を満たさないものを
「$\mathbb{R}$ 脱出として隔離する」へ落とす。

| 種別 | 件数 |
| --- | --- |
| 自分で証明する | 7 |
| mathlib から引く | 7 |
| $\mathbb{R}$ 脱出として隔離する | 2 |
| 対象外 | 11 |

長所は、**隔離できていることを台帳が型で要求している**点である
（可算側の主張がその定理に依存していないことの根拠を書かないと通らない。
依存していれば「自分で証明する」へ落とす規則になっている）。
短所は二つある。第一に、上の実測のとおり**実数を使っても機械検証は弱くならない**ので、
② は検証の強さを守るための条件ではない。第二に、隔離できているかの判定は人の読みであり、
**台帳自身が「機械が確かめられないこと」としてそう書いている**。

### mathlib 在否案 — 一般的すぎて形式化が冗長になるものだけを外す

「一般的すぎる」を判定できる形にする案は、実測できるものが一つある。

> **操作的定義: mathlib に在るものを「一般的すぎる」とみなす。**
> 人類が既に形式化して標準ライブラリへ入れたということ自体が、
> その定理が汎用の道具であることの実測値である。判定は走査（`lean/scripts/mathlib-gap-survey-*.sh`）
> でつき、走査ログのコミットを残せば腐りも検出できる。

この定義を採ると、**現行の三条件から ②（可算側の内容を担う）を落とすことと同じになる。**
振り分けは次のように動く。

| 種別 | 現行案 | mathlib 在否案 | 動く中身 |
| --- | --- | --- | --- |
| 自分で証明する | 7 | **9** | $\mathbb{R}$ 脱出の 2 件が移ってくる |
| mathlib から引く | 7 | 7 | 動かない |
| $\mathbb{R}$ 脱出として隔離する | 2 | **0** | 枠そのものが無くなる |
| 対象外 | 11 | 11 | 動かない（そもそも根拠として引いていないので、どの案でも動かない） |

**移る 2 件が何かは実測で決まっている。**

- **エントロピー＝Mahler 測度（Lind–Schmidt–Ward, Invent. math. 101 (1990) Theorem 3.1 / 7.1）**
- **周期点の増大率（Lind–Schmidt–Verbitskiy, arXiv:1108.4989 Theorem 1.2 / 1.3）**

この 2 件は **mathlib に無い**。走査ログ
（`lean/logs/mathlib-gap-survey-cycle31-external.log`、mathlib `520045ab14`・8264 ファイル）では
`lind schmidt` が 3 段とも 0 件である。Mahler 測度そのものは
`Mathlib/Analysis/Polynomial/MahlerMeasure.lean` と `Mathlib/NumberTheory/MahlerMeasure.lean` に
在るが、**同ログが「両ファイルとも `MvPolynomial` の出現 0 件」と記録している**＝1 変数のみである。
本論文が要るのは多変数である。したがって 2 件は「mathlib から引く」へは行かず、
**「自分で証明する」へ行く**。

**ただし「定理が無い」と「素材が無い」は別である。** 位相的エントロピーの定義は mathlib に在る
（`Mathlib/Dynamics/TopologicalEntropy/CoverEntropy.lean` の `coverEntropy`。Bowen–Dinaburg の被覆版で、
値は `EReal`）。ただし対象は 1 つの写像 $T:X\to X$（$\mathbb{Z}$ 作用）であり、
この 2 件が扱う $\mathbb{Z}^d$ 作用のエントロピーはその形では書けない。
すなわち積むことになるのは、$\mathbb{Z}^d$ 作用のエントロピーと多変数 Mahler 測度である。
上の走査は定理の名前で引いたものなので、道具の側の在否はこのように別に測る必要がある
（「証明の手間」の節に挙げた Monsky の例と同じ話である）。

長所は、線引きが**走査で判定できる一本の条件になる**ことである
（現行の ② は「主張が可算の言葉で閉じているか」という人の読みを含む）。
短所は、**書く量が増え、しかもその量が事前に見積もれない**ことである
（前節の「事前判定が何度も覆っている」を参照）。

なお「一般的すぎる」を**積む素材の量で測る**案も考えられるが、
これは判定できる形にならない。台帳の履歴が、素材の有無の事前判定が
少なくとも 3 回（Euler の双対基底公式・Newton 多面体・Monsky）覆ったことを記録している。

### 2 軸案 — 「書く／引く」と「実数へ出るか」を別々の軸にする

上の実測が示しているのは、**現行基準が 1 本の軸に 2 つの別々の判断を載せている**ことである。

- **書くか引くか** — mathlib に在るかで決まる。走査で判定できる。
- **実数へ出るか** — 主張がどこに住んでいるかで決まる。研究上の記録として要る。

これを 2 軸に分ける案である。振り分けの件数は mathlib 在否案と同じ（9 / 7 / 0 / 11）だが、
**「$\mathbb{R}$ 脱出である」という宣言は消さず、全エントリが持つ別の欄にする。**
現在 2 件が持っている「なぜ主張の本体が $\mathbb{R}/\mathbb{C}$ の解析なのか」と
「可算側の主張がそれに依存していないことの根拠」は、その欄へそのまま移せる。

長所は、**実数への脱出の記録という研究上の資産を、形式化の作業計画から切り離して保てる**ことである。
現行では「隔離する」と宣言することが「形式化しない」と同義なので、
**記録したいだけの場合にも作業対象から外れてしまう**。
短所は、台帳と、それを毎回印字して腐りを検出する検査（`npm run verify:formalization`。
基準の正本が「検査 F」と呼んでいるもの）の構造を変える手が入ることと、
mathlib 在否案と同じく書く量が 2 件ぶん増えることである。

## リポジトリの思想との関係

`docs/context/` の三層を読むと、実数について二つの別々の線が引かれている。

- **理論物理レイヤー**（[物理を記述する数学の選び方](../../docs/context/物理を記述する数学の選び方.md)）——
  $\mathbb{R}/\mathbb{C}$ は**道具としては使うが研究対象としては採らない**。
  同ファイルは「反 $\mathbb{R}$ ではない」「$\mathbb{R}$ を使うな、とは言わない」とまで書いている。
  これは**何を研究するか**の線である。
- **方法論レイヤー**（[成果の出し方](../../docs/context/成果の出し方.md)）——
  **機械が信頼できるのは、等号が決定可能な世界だけである。**
  これは**何を機械にかけるか**の線である。

同ファイルは、この二つが「同じ境界線を別方向から指している」ことをこの研究方針の骨格として挙げている。
**今回の実測は、その一致が成り立つ層を限定する。**

一致しているのは**計算の層**である。$\mathbb{R}$ の等号が決定不能であることは、
SageMath の厳密計算と Lean の `decide` がそこで止まるという形で実際に効いている（上の実測）。
一致していないのは**証明の層**である。Lean の kernel も `check-no-sorry.sh` も、
実数を使った証明を使わない証明と同じ規則・同じ基準で検査する。
**「等号が決定可能か」は計算の層の境界であって、証明の層の境界ではない。**

現行基準はこの二つを 1 本の線として扱っている。基準の導出部が
「$\mathbb{R}$ 側の定理を形式化しても、この研究が担う内容は増えない」と書いているのは
研究対象の線であり、それを**形式化の対象の線**として使っている。
そこが論点になる。両側の言い分は次のとおりである。

- **同じ線でよいとする側の根拠。** 外部定理を自分で書く理由は、それが
  「本論文の主張の内容そのものを担っている」からである（基準の「自分で証明する」の条）。
  内容を担っていない実数側の定理を書いても、成果は増えず物量が増えるだけである
  （成果の出し方の「物量そのものに価値があるのではない」）。
- **別の線にすべきとする側の根拠。** 基準の導出部が
  [証明の書き方](../../docs/context/証明の書き方.md)の「根拠の明示」から引き出しているとおり、
  **証明の根拠として引いた以上、その根拠が正しいことは主張の正しさの一部**である。
  実数側だから証明しない、というのはこの規律に例外を作ることにあたる。
  現行基準はその穴を「隔離できていることを機械の側で要求する」ことで塞いでいるが、
  **隔離の判定そのものは人の読み**であり、台帳がそう明記している。

**判断の規模はこの実測で分かっている。** 動くのは 27 件のうち 2 件であり、
本文の主張ブロックのうち実数に住むものも 36 件中 2 件である。
どの案を採っても、**このプロジェクトの形式化作業の大半（本文 34 件・外部定理 25 件）は影響を受けない。**
選ぶのは作業量ではなく、**台帳が何を記録し、何を根拠に線を引いていると読者に示すか**である。
