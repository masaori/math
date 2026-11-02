# SageMath Check: sine_integral_constant_numerical_bound

## 対象

**対象ラベル**: `sine_integral_constant_numerical_bound` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/020_critical_point.ts`
- ブロック: `critical_claim_sine_integral_constant_numerical_bound`（def_sine_integral_constant の B について B ≤ 0.88）
- 範囲: 準備の 1 + c0 ≥ 1.5887、12c0(1+c0) ≥ 11.22 の鎖の 4 行、B の鎖の 6 行と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備 1 + 0.5887 = 1.5887 | `check_proof_lines.sage` | QQ | **PASS** | 成り立つ |
| 12c0(1+c0) の鎖の 1・2 行目（≥） | `check_proof_lines.sage` | 差を 12(1+c)(c - 0.5887)、12·0.5887·(c - 0.5887) に因数分解（QQ[c]）し、c ≥ 0.5887 の下で非負 | **PASS** | 成り立つ |
| 同じ鎖の 3・4 行目 | `check_proof_lines.sage` | 12·0.5887·1.5887 = 11.22321228 ≥ 11.22 を QQ で | **PASS** | 成り立つ |
| 準備の逆数の鎖（1/(12c0(1+c0)) ≤ 1/11.22） | `check_proof_lines.sage` | 等号と差 (X - 11.22)/(11.22X) の式を QQ(X) で。大小は π のボールで | **PASS** | 成り立つ |
| B の鎖の 2・3 行目（≤） | `check_proof_lines.sage` | X := 12c0(1+c0)、π² を不定元にした QQ(X, π²) で差を (9.8697 - π²)/X、9.8697(X - 11.22)/(11.22X) に書いた式を確かめる（非負であることは式の形から読む）。大小そのものは π のボールで | **PASS** | 成り立つ |
| B の鎖の 4〜6 行目 | `check_proof_lines.sage` | 9.8697/11.22 = 98697/112200、98697 ≤ 98736、98736/112200 = 0.88 を QQ で | **PASS** | 成り立つ |
| 主張 | `check_proof_lines.sage` | 入力の範囲の最悪の場合 9.8697/(12·0.5887·1.5887) ≤ 0.88 を QQ で。π の Arb のボールで B ≈ 0.879256 ≤ 0.88 | **PASS** | 成り立つ |
| 対照 | `check_proof_lines.sage` | c0 の下界を 0.58 に粗くすると 0.88 以下を示せない | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: 鎖の各行は QQ・QQ[c]・QQ(X, π²) で確かめた。
- **`ℝ` への脱出（`RealBallField(256)`）**: B の値と、c0 を含む行の大小の確認だけ。π が QQ に入らないためである。判定は差のボールの下端の符号で行い、許容誤差は置かない。
- 範囲外: 入力 c0 ≥ 0.5887（sine_bound_constant_numerical_bounds）と π² ≤ 9.8697（pi_squared_numerical_bounds）はそれぞれの検算で確かめている。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh sine_integral_constant_numerical_bound
```

実行ログは `logs/` に保存する。
