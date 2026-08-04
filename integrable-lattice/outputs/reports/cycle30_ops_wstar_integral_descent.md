# cycle 30 step 1 — 命題 W\* の整数への降下

日付: 2026-08-04 / 対象: 命題 W\*（$w^*$ の代数的閉形式。トレース双対と微分）

## 結論

命題 W\* に残っていた 2 段のうち、整数への降下を形式化した。残るのは 1 段（$\rho$ が可約な場合）である。
被覆の件数は動いていない（完了 6・部分的 16・未着手 2、残り 18 件のまま）。
1 段では完了に届かないので、これは前サイクルの教訓「段を動かしても件数は減らない」の 2 例目である。

## 着手時の実測

検査 F の実出力（本サイクル着手時）は 主張 24 件 / 完了 6・部分的 16・未着手 2 / 残り 18 件、
`lean/` の宣言 493 件。命題 W\* の残りは台帳の理由欄のとおり 2 段で、どちらも
「mathlib の欠落ではなくこちらの未記述」と書かれていた。この判定のうち片方は誤りだった（後述）。

## 何を書いたか

`lean/IntegrableLattice/WStarIntegralDescent.lean`（定義 1 件・定理 7 件）。

1. Euler の係数行列が $\rho$ の係数の Hankel 行列であること: $C_{ij}=\rho_{i+j+1}$。
   反対角線より下は次数から $0$、反対角線はモニック性から $1$ なので、
   列を逆順にすると対角成分がすべて $1$ の上三角行列になり $\det C=\pm1$ が出る
   （`isUnit_det_eulerHankel`）。可換環の上で成立し、体も分離性も既約性も使わない。
2. $\rho(y)/(y-\theta)$ の $y^i$ の係数が $\sum_j\rho_{i+j+1}\theta^j$ に等しいこと
   （`coeff_minpolyDiv_eq_sum`）。mathlib の漸化式 `coeff_minpolyDiv`（$c_i=\rho_{i+1}+c_{i+1}\theta$）
   についての帰納法で出る。
3. 体の上で座標として定義してあった `eulerMatrix` が 1 の行列に一致すること
   （`eulerMatrix_eq_eulerHankel`）。これが「$C$ の整数への降下」の中身である。
4. 降下そのもの（`isLeast_isPLevel_range_of_euler`）。可逆な整数行列 $C$ と $C\,G=M_\eta$ から、
   $G$ の像の $p$ レベルが $\eta A$ の $p$ レベルに等しいことを出す。
   人手証明の「$\operatorname{coker}(G)\cong A/\eta A$ だから $G$ の単因子は $A/\eta A$ の不変量」の中身であり、
   `WStarElementaryDivisors.lean` の `isLeast_isPLevel_ideal` と繋がって
   $w^*=\min\{j:\ p^j\eta^{-1}\in A_{(p)}\}$ を与える。

## 台帳の予定と実際が違った点（本 step の主な所見）

台帳は残りの 1 つを「$C$ の成分が整数であること。`coeff_minpolyDiv_mem_adjoin`（$c_i\in R[\theta]$）が
mathlib に在るので、その所属を冪基底の座標が整数であることへ翻訳する配線が要る」と書いていた。

実際に書くと、所属を経由する必要は無かった。$C$ の成分は「整数である」より強く
$\rho$ の係数そのものであり、等式で書ける。所属の議論も座標への翻訳も要らず、
`coeff_minpolyDiv_mem_adjoin` は 1 度も使っていない。
壁ではなく道筋のほうが、一次情報に当たると変わった例である。

## 残っている 1 段と、その根拠

$\rho$ が可約な場合の $C\,G=M_\eta$ そのもの。既存の `eulerMatrix_mul_weightedGram` は
`PowerBasis K L`（$L$ は体）を使っており、$\rho$ が既約な場合しか覆っていない。
$\rho$ が可約なとき $A\otimes\mathbb{Q}$ は体でなく体の積である。

これは配線の欠落ではなく素材の欠落である。根拠は
`lean/logs/mathlib-gap-survey-cycle30-euler.log`（mathlib `520045ab14`、Mathlib/\*.lean 8264 ファイル走査）:

- 可換環の上のトレース双対・可換環の上の双対基底・Euler の双対基底公式・Frobenius 代数は、
  いずれも連結語の grep が 0 件。
- 語の不在だけでは「体の上にしか無い」を示せないので、実在する宣言の仮定を直接読んだ。
  `Module.Basis.traceDual` は `[Field K] [Field L] [FiniteDimensional K L] [Algebra.IsSeparable K L]`
  を要求している（宣言行と直前の variable 行を log に載せた）。

埋めるには可換環の上の Euler の双対基底公式 $\operatorname{Tr}_{A/R}(c_i\theta^j)=\delta_{ij}$ を
自前で書くことになる。本 step は書いていない。書く場合の見通しも測った範囲で正直に書くと、
この公式は $\operatorname{Tr}(\theta^m)$ が満たす Newton 型の関係に帰着し、
mathlib の Newton 恒等式（`MvPolynomial` の psum / esymm）は根を持つ設定にあるので、
companion 行列のトレースへ繋ぐ段が別に要る。見通しを立てただけで、書いて通したものではない。

## 過剰仮定（5 サイクル連続）

linter が 2 件挙げ、どちらも実際に不要だったので `omit` で落とした。

- `eulerMatrix_eq_eulerHankel` に有限次元性は要らない（効くのは冪基底があることと、
  $\rho$ がその生成元の最小多項式であることだけ）。
- `range_mulLeft_eq_span` に整域であることは要らない。

## 実在確認のログについて（この step で直したこと）

`scripts/mathlib-gap-survey-cycle30-euler.sh` の名指し確認は、最初の版が偽の未検出を 8 件出した。
原因は 3 つで、いずれも実データを見て直した。

1. 名前に `'` を含む宣言（`Finset.sum_range_succ'` 等）が `\b` で切れない。
2. 宣言行に名前空間が部分的に付く（`theorem Basis.repr_sum_self`）。
3. `@[to_additive]` で生成される加法版は宣言行を持たない
   （`Finset.sum_range_succ'` は `Finset.prod_range_succ'` から、
   `Fin.sum_univ_eq_sum_range` は `Fin.prod_univ_eq_prod_range` から生成される）。

直した結果、実在確認は 20 件 OK・3 件 OUT になった。OUT は「無い」ではなく
「Mathlib/\*.lean の中に宣言行が無い」であり、log ではそう書き分けている。
文字列検査で実在を否定できない範囲があること自体を log に残した。

## 自分の誤りの記録

1. 行列式の議論の最後を、符号の二乗を経由する形で書き始めて破綻させた
   （$\pm1$ を掛けて戻す計算を組み立てようとして、途中で目標を見失った）。
   実際には $\mathrm{sign}\cdot\det H=1$ から直ちに単元性が出る。初回のコンパイルで気づいて書き直した。
2. `isUnit_of_mul_eq_one` という名前を実在確認せずに書いた（正しくは `isUnit_iff_exists_inv`）。
   実在しない補題名を書く誤りの再発である。最終成果物には残っていない。
3. `omit ... in` を docstring と定理の間に置いて構文エラーにした（正しくは docstring の前）。

## 検証

- `lake build` 8689 jobs exit 0。
- `check-no-sorry.sh` 列挙 449 → **456 件**、すべて sorryAx 非依存（exit 0）。
- `npm run check`（29 段）exit 0。検査 F の実出力で `lean/` の宣言 493 → **501 件**、
  被覆は 完了 6・部分的 16・未着手 2 / 残り 18 件（変わっていない）。
- `build:pdf` 日 **50 頁**・英 **64 頁**（どちらも不変）。
- 設計どおり赤くなった副作用 1 件: 台帳から `Mathlib/FieldTheory/Minpoly/MinpolyDiv.lean` への参照が
  消えたので、腐ったツール参照の検査の免除が「登録が古い」で赤くなった。免除を削除して緑に戻した。

## 限界

- 4 の降下は $C\,G=M_\eta$ を仮定として受け取る形であり、その仮定を供給できるのは既約な $\rho$ の場合だけである。
  したがって命題 W\* の主張のうち一般の $\rho$ については、まだ機械が確かめていない。
- 「素材が無い」の根拠は 3 段の走査と宣言の仮定の直読であって、不在の証明ではない。
- 3 の一致は最小多項式についての等式であり、本文の $\rho=\mathrm{rad}(\chi_T)$ が
  $\theta$ の最小多項式であること自体は、既約な場合にしか結び付けていない。
