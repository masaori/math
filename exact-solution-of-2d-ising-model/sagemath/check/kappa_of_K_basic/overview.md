# SageMath Check: kappa_of_K_basic

## 対象

**対象ラベル**: `kappa_of_K_basic`

- ファイル: `structured-latex/content/critical_point_and_log_divergence.ts`
- ブロック: `critical_006_claim_kappa_of_K_basic`（κ(K) の基本性質と臨界点 K_c）
- 範囲: 主張の K_c と (1)〜(5)、証明の準備四つ（K_c > 0・cosh 2K_c = √2・√2 の小数の評価・数値の評価）と各段の鎖の全行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 主張の K_c（sinh 2K_c = 1、2K_c = arcsinh(1) = log(1+√2)） | `check_critical_point_exact.sage` | w = exp(2K) で sinh 2K = 1 ⟺ w² − 2w − 1 = 0 の正の根が 1 + √2 だけ（AA）、def_arcsinh の値と一致 | **PASS** | 厳密 |
| 準備 K_c > 0 の背理法の 3 行 | `check_critical_point_exact.sage` | w_c > 1。(w − 1/w)/2 = (w − 1)(w + 1)/(2w) と、w ∈ (0, 1] の 5 点で ≤ 0、sinh 0 = 0 | **PASS** | 厳密 |
| 準備 cosh 2K_c = √2 の 4 行と結論 | `check_critical_point_exact.sage` | AA で各行、cosh 2K_c > 0・√2 > 0、対照 −√2 | **PASS** | 厳密 |
| 準備 √2 の小数の評価の 5 行 | `check_critical_point_exact.sage` | QQ で 2 乗の値と大小、AA で結論、対照 | **PASS** | 厳密 |
| 準備 数値の評価 cosh(1/5)・sinh(1/5)（持ち込む事実） | `check_bounds_with_balls.sage` | 本文の exp のボールで両側、対照として桁を一つ詰めると落ちる | **PASS** | ボール |
| (1) (tanh)' の 4 行 | `check_derivative_lines.sage` | v = exp(K) の QQ(v) の導分 v·d/dv で各行、対照（商の微分の符号） | **PASS** | 厳密 |
| (1) dK^*/dK の 7 行 | 同上 | QQ(v) で 3〜7 行目（log∘T の導関数は Dv(T)/T）。定義・定数倍・合成の 1〜3 行目と両端は SR の記号微分で独立に（左辺は SR の diff(−log(tanh K)/2)、両辺を exp で書いて厳密に）。対照 −1/sinh K | **PASS** | 厳密 |
| (1) κ' の 5 行と κ' > 2 > 0 の 3 行 | 同上 | SR で和・定数倍・恒等関数の行と両端、QQ(v) で 2 − 2dK^*/dK = 2 + 2/sinh 2K、κ' − 2 = 4v²/(v⁴ − 1)（v > 1 で正）。対照（K^* の符号） | **PASS** | 厳密 |
| (1) 狭義単調増加の 4 行（(R4)・(R3)） | `check_bounds_with_balls.sage` | 三つの区間で ∫_a^b κ' = κ(b) − κ(a)、≥ 2(b − a) を Arb の積分で | **PASS** | ボール |
| (2) 同値の鎖の 7 行と κ(K_c) = 0 | `check_critical_point_exact.sage` | 各行の条件を w = exp(2K) の多項式の零点にし、w > 1 での零点の集合が一致（AA）。1→2 行目は def_kappa の κ を def_second_dual_coupling_constant の K_2^* から w_1, w_2 で作り w_1 = w_2 を代入して κ(K) の条件と一致、3 行目は QQ(w_1,w_2) の代入、対照（K_1 ≠ K_2、w < 1 の根 √2 − 1、K > 0 を外すと根が増える） | **PASS** | 厳密 |
| (3) κ'' の 10 行 | `check_derivative_lines.sage` | QQ(v) の導分で和・定数・商・合成（v ↦ v² の代入が 2 id との合成）・sinh' の各行、対照（合成の 2 を落とす） | **PASS** | 厳密 |
| (4) 端点の式の 2 行（sinh(2K_c ± 1/5)） | `check_bounds_with_balls.sage` | 左辺を sinh の定義と exp(2K_c ± 1/5) = (1+√2)exp(±1/5) から、右辺を加法定理の形と cosh(1/5) ± √2 sinh(1/5) から作って重なる。対照（複号の取り違え） | **PASS** | ボール |
| (4) sinh 2K の下界・上界の鎖（各 6 行） | `check_bounds_with_balls.sage` | ボールの行は大小、最後の行は QQ で厳密。対照（上界 1.3047） | **PASS** | ボール・厳密 |
| (4) K > 0 と 2K_c − 1/5 > 0 | `check_bounds_with_balls.sage` | exp(2K_c − 1/5) > 1 | **PASS** | ボール |
| (4) κ' の上下界の 6 行 | `check_bounds_with_balls.sage` | QQ の格子点 9 点で各行をボールで、最後の行を QQ で | **PASS** | ボール・厳密 |
| (4) h' の 6 行 | `check_derivative_lines.sage` | QQ(v) で各行、4cosh 2K/sinh² 2K = 4h(2K) | **PASS** | 厳密 |
| (4) h の単調減少の 3 行（(R4)・(R3)） | `check_bounds_with_balls.sage` | ∫_a^b h' = h(b) − h(a) < 0 を三つの区間で | **PASS** | ボール |
| (4) cosh(2K_c − 1/5) の 6 行 | `check_bounds_with_balls.sage` | 1・2 行目は定義から作った値と重なり、以降は大小、最後の行は QQ | **PASS** | ボール・厳密 |
| (4) |κ''| の 8 行・|(κ'²)'| の 4 行 | `check_derivative_lines.sage`・`check_bounds_with_balls.sage` | (κ'²)' = 2κ'κ'' と 4cosh 2K/sinh² 2K = 4h(2K) を QQ(v) で。QQ の格子点 9 点で各行をボールで、最後の行を QQ で | **PASS** | 厳密・ボール |
| (5) 一つ目の鎖の 14 行・∫G' の挟み込みの 4 行・二つ目の鎖の 7 行・κ'(K_c) = 4 | `check_bounds_with_balls.sage` | QQ の格子点 9 点ごとに a = min{K, K_c}、b = max{K, K_c} を作り、各行の値（積分は Arb の数値積分。端点 K_c は QQ の中心で、ずれは 87 倍の半径を誤差に足す）を隣の行と比べる。最後の行は QQ で。(R4) の行は別に三つの区間でも | **PASS** | ボール・厳密 |
| 主張 (4)・(5) | `check_bounds_with_balls.sage` | K ∈ {0.3407, 0.36, 0.4, 0.44, 0.4407, 0.45, 0.5, 0.54, 0.5406} と端点 K_c ± 1/10 の 11 点で全不等式。κ(K) = 2K − 2K^* が log(w(w−1)/(w+1)) と重なる。対照: K = 0.2・0.7 で評価が崩れる | **PASS** | ボール（ファイル全体で真偽の確認 525 件、うち対照 7 件） |

## 計算の帰属と範囲

- **厳密**: 導関数の行は v = exp(K) の有理関数体 `QQ(v)` の導分 v·d/dv（f(K) = F(exp K) の導関数は exp' = exp と合成の微分で v·F'(v)）、
  K_c と (2) は w = exp(2K) の `QQ[w]` と `AA`、小数の行は `QQ`（小数は文字列から `QQ` に直し、浮動小数点を経ない）。
  w・v への書き換えと、K > 0 ⟺ w > 1、exp の単射性は検算の側で使う標準の事実で、本文の証明には無い。
- **ℝ への脱出（`RealBallField(256)`）**: cosh(1/5)・sinh(1/5)・端点の値・具体の K での主張・(R4) を当てた積分の行。
  cosh・sinh の値は本文の exp の部分和に尾の評価を半径として足したボール（`body_real_exp_ball`）から作り、
  exp(2K_c) = 1 + √2 は `AA` の値をボールにする。log と積分は Arb（`log`、`ComplexBallField.integral`）で囲む。
  判定の決まりは `sagemath/_shared/isotropic_balls.sage`（許容誤差なし。等号は重なりと差の半径 2^{−100} 未満、不等号はボールの大小。決まらなければ失敗）。

## 確かめられない行と理由

- 微分の公式・(R3)・(R4) そのもの（本文が外部から持ち込む実数解析の事実）。ここでは当てた行の両辺の一致だけを確かめる。
- 数値の評価 cosh(1/5)・sinh(1/5) は本文では証明せずに持ち込む事実で、ボールで成り立つことだけを確かめる。
- 区間 [K_c − 1/10, K_c + 1/10] の全ての点での主張と鎖（主張は具体の 11 点、(4)・(5) の鎖の各行は QQ の格子点 9 点だけ。端点 K_c ± 1/10 では鎖の各行を確かめていない）。
- (1)・(4) の「微分可能」「連続」の段（微分の公式を当てた結論で、等号・不等号の行ではない）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh kappa_of_K_basic cosh_derivative
```

`sage` が PATH に無いときは `~/micromamba/envs/sage/bin/sage` を PATH に足す。実行ログは `logs/` に保存する。
