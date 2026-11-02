# SageMath Check: two_by_two_transfer_identity

## 対象

**対象ラベル**: `two_by_two_transfer_identity`

- ファイル: `structured-latex/content/partition_function_transfer_matrix_representation.ts`
- ブロック: `bridge_005_claim_two_by_two_transfer_identity`（2×2 の転送行列の恒等式 `A = (2s_2)^{1/2} exp(K_2^* σ^x)`）
- 範囲: 証明の全行と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備: `(b^(m))_ij = (β^(m)_ij)_C`（4 通りの表） | `check_series_term_entries.sage` | `m = 0..20` の全成分 | **PASS** | 一致 |
| 準備: `0 < t < 1`、`r² = t`、`q² = 2s_2`、`r > 0`、`q > 0` | `check_hyperbolic_lines.sage` | `K_2 = log x` の 5 点で `QQ`・`AA`、`K_2 ∈ QQ` の 5 点でボール | **PASS** | 成り立つ |
| 準備: `x_C - y_C = (x - y)_C` の鎖 6 行 | `check_partial_sums_and_limit.sage` | 4 組の有理数で、本文の `ℂ = ℝ²` の成分の和と積（`definition_of_cc`）を直接書いて比べる。定義を展開しただけの初めの 3 行は同じ式になり独立には確かめない。実効があるのは積の像・和の像・実数の四則の 3 行 | **PASS** | 一致 |
| 「B_τ の冪」: `B_τ^0` の鎖 3 行、`B_τ^{2p+1}` の鎖 8 行、`B_τ^{2p+2}` の鎖 9 行、まとめ `B_τ^m = (τ^m)_C b^(m)` | `check_powers_of_B.sage` | `p = 0..10`（まとめは `m = 0..21`）。冪は本文の `A^{m+1} := A^m A` で作る。否定コントロール（奇数の冪を `I` の倍、偶数の冪を `σ^x` の倍とした式）は不一致 | **PASS** | 一致 |
| 「各項の成分」: `((1/m!)B_τ^m)_ij` の鎖 6 行、実数 `(1/m!)τ^mβ^(m)_11`・`β^(m)_12` の鎖 各 3 行 | `check_series_term_entries.sage` | `m = 0..20` の全成分。否定コントロール（対角と非対角の入れ替え）は不一致 | **PASS** | 一致 |
| 「部分和の成分」: `(S_N)_ij` の鎖 各 5 行（対角・非対角） | `check_partial_sums_and_limit.sage` | `N = 0..24` で厳密に | **PASS** | 一致 |
| 「部分和の成分の極限」: `|(S_N)_ij - (cosh τ)_C|`・`|(S_N)_ij - (sinh τ)_C|` の鎖 各 6 行 | `check_partial_sums_and_limit.sage` | 等号の行の書き換えは `exp(±τ)` を不定元 `X, Y` に置いて `QQ(X,Y)` で、三角不等式の行は `τ ∈ QQ` の 6 点・`N ∈ {5,20,60,120}` でボールで | **PASS** | 成り立つ |
| `u_N, v_N → 0` と `(S_N)_ij → (cosh τ)_C, (sinh τ)_C`、`exp(τσ^x)` の行列 | `check_partial_sums_and_limit.sage` | `N = 200` で `u_N, v_N < 2^{-300}`。行列の部分和のボールと本文の `cosh`・`sinh` のボールが重なる。否定コントロール（対角と非対角の入れ替え）は重ならない | **PASS** | 成り立つ |
| 「τ = K_2^* として」の鎖 4 行 | `check_claim.sage` | 右辺の行列のボールと、`K_2^*` のボールから本文の `cosh`・`sinh` で作った `[[q cosh K_2^*, q sinh K_2^*], …]` が重なる | **PASS** | 成り立つ |
| 「exp(±K_2^*) を r で書く」: `exp(-2K_2^*)` の鎖 4 行、`(exp(-K_2^*))²` の鎖 3 行、`exp(-K_2^*) = r`、`exp(K_2^*) r` の鎖 3 行、`exp(K_2^*) = 1/r` | `check_hyperbolic_lines.sage` | `-2·(-1/2) = 1` は `QQ`。exp の値の行は、log を有理数の端点の区間で挟んだ `K_2^*` から本文の exp のボールで作り、`t`・`r`（`AA` またはボール）と重なることを見る | **PASS** | 成り立つ |
| `cosh K_2^*` の鎖 4 行、`sinh K_2^*` の鎖 4 行 | `check_hyperbolic_lines.sage` | 1 行目は `K_2^*` のボールから本文の `cosh`・`sinh` で、2〜4 行目は `AA`（`log x` の点）とボールで | **PASS** | 成り立つ |
| `1 + t`・`1 - t` の鎖 各 3 行 | `check_hyperbolic_lines.sage` | `QQ(E)`（`E = exp(K_2)`） | **PASS** | 一致 |
| 「前因子」: `(q/(2r))²` の鎖 9 行と `q/(2r) = cosh K_2` | `check_hyperbolic_lines.sage` | 初めの 4 行と `q/(2r) > 0`・`q/(2r) = cosh K_2` は `AA` とボール、`2s_2/(4t)` 以降の 6 行と倍角公式の両辺（`sinh 2K_2` を定義の `(E² - E^{-2})/2` から、右辺を `E` から別々に作る）は `QQ(E)`。倍角公式を当てた行と `2K_2/2 = K_2` の行は、`E` で持つと区別できないので 1 つの項で確かめる | **PASS** | 成り立つ |
| 「示すべき 2 つの等式」: `q cosh K_2^*`・`q sinh K_2^*` の鎖 各 5 行 | `check_hyperbolic_lines.sage` | `AA`（`log x` の点）とボール | **PASS** | 一致 |
| 「結論」: `A` から右辺への鎖 3 行と主張 | `check_claim.sage` | 証明の閉じた形を通らず、左辺を本文の exp のボール、右辺を行列の部分和のボールで作って重なりを見る。否定コントロール（`K_2^*` を `K_2` にした右辺、前因子を `2s_2` にした右辺）は重ならない | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: 冪・各項の成分・部分和の行は、`τ` を不定元とする `GAUSSIAN[τ]`（`GAUSSIAN = QQ(i)`）の行列で確かめた。
  不定元での多項式の等号は、`τ` へ任意の実数を代入しても成り立つ。本文の包含 `a ↦ a_C` は、実数の側の `QQ[τ]` から
  `GAUSSIAN[τ]` への環準同型 `inc` として持ち、`real_inclusion_preserves_product`・`real_inclusion_preserves_finite_sum` の行は
  `QQ[τ]` で積・和を取ってから写した値と、写してから積・和を取った値を比べた。`inc` は環準同型なのでこの二つは必ず一致する。
  これらの行で確かめているのは、行の両辺の式の形（どの積・和を取ったか）が証明と合っていることである。
  `exp`・`log` を含まない双曲線関数の行は、`E = exp(K_2)` を不定元とする `QQ(E)` で確かめた（`exp(-K_2) = 1/E`）。
  `r = √t`・`q = √(2s_2)` を含む行は、`K_2 = log x`（`x ∈ QQ`、`x > 1`）の点で `AA` の中で確かめた
  （`exp(K_2) = x` なので `t`・`2s_2` は `QQ`）。
- **`ℝ` への脱出（`RealBallField(512)`）**: 理由は二つ。(1) 極限: `exp(τσ^x)` の成分と `cosh τ`・`sinh τ` は級数の極限で、
  `QQ` に収まらない。行列の exp は本文の部分和をボール演算で計算し、尾を `2(2b)^{N+1}/(N+1)!`（`b` は成分の絶対値の上界）で
  抑えた半径を足した（Arb の exp は使わない）。(2) 実対数と指数評価: `K_2^* = -(1/2)log t` は `QQ` にも `AA` にも収まらない。
  log は有理数の端点 `lo < hi` の区間で挟み、端点は本文の exp のボールで `exp(lo) < t < exp(hi)` を確かめてある
  （共通の準備 `sagemath/_shared/positive_coupling_and_real_log.sage` の `real_log_enclosure`）。
  ボールの判定は重なりと半径の上限（主張の検算では `2^{-100}`。log の区間の幅 `2^{-130}` 程度が支配的）だけで行い、許容誤差は置かない。
- 否定コントロールの `K_2` のボールだけは Arb の log で作った。否定の判定にしか使わない。

範囲外のもの: 選んだ以外の点（`p ≤ 10`、`m ≤ 20`、`N ≤ 24`、`τ`・`K_2` の有限個の点）。
「`ε` に対し `N_1, N_2` を取る」という収束の議論そのものは計算を含まないので、検算では `u_N` が大きな `N` で小さいことと、
三角不等式の行が具体の `N` で成り立つことだけを見る。集合への所属だけを述べる行と、記号を置くだけの行は計算を含まない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh two_by_two_transfer_identity
```

実行ログは `logs/` に保存する。このディレクトリの共通の準備は `_prelude.sage`。
