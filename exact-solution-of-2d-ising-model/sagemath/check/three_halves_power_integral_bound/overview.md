# SageMath Check: three_halves_power_integral_bound

## 対象

**対象ラベル**: `three_halves_power_integral_bound` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/020_critical_point.ts`
- ブロック: `critical_claim_three_halves_power_integral_bound`（δ, a > 0 なら ∫_0^π dθ/(δ²+a²θ²/4)^{3/2} ≤ 2/(aδ²)）
- 範囲: w' の鎖、r' の鎖、G' の鎖、r(π) > aπ/2 の背理法の鎖、積分の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| w' の鎖 | `check_proof_lines.sage` | QQ[a,δ,θ] の多項式の微分として厳密に | **PASS** | 成り立つ |
| r' の鎖と G' の鎖の各行（最後は def_three_halves_power の w√w） | `check_proof_lines.sage` | 関数体 QQ(a,δ)(θ)[r]/(r²-δ²-a²θ²/4) の θ についての微分で、D(G) と各行が一致 | **PASS** | 成り立つ |
| 背理法の鎖の 4〜6 行目の等号と <、1/r(π) の鎖の等号、積分の鎖の 3・4・6 行目 | `check_proof_lines.sage` | π を不定元に置いた QQ(a,δ,p)[r]/(r²-δ²-a²p²/4) で厳密に | **PASS** | 成り立つ |
| r(π) > aπ/2、積分の鎖の 1〜3 行目（(R4) の当てはめ）・5 行目の大小と主張 | `check_proof_lines.sage` | 5 点の (δ, a) で Arb の厳密な数値積分のボールと π のボール | **PASS** | 成り立つ |
| 対照 | `check_proof_lines.sage` | 上界を 1/(aδ²) にすると成り立たない（δ = 1/100, a = 1/2）。関数体で 1/(w√w) ≠ 1/w | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: w' の鎖は `QQ[a,δ,θ]` で、r'・G' の鎖は関数体 `QQ(a,δ)(θ)[r]/(r²-δ²-a²θ²/4)` の θ についての微分で、背理法の鎖の等号・1/r(π) の鎖の等号・積分の鎖の 3・4・6 行目は π を不定元 p に置いた `QQ(a,δ,p)[r]/(r²-δ²-a²p²/4)` で確かめた。背理法の鎖の 5 行目の < は、差が δ² > 0 であることに帰着させた。
- **`ℝ` への脱出（`RealBallField(512)`・`ComplexBallField(256)`）**: π と積分の値だけ。値が QQ・AA に入らないためである。判定は差のボールの下端の符号（大小）と、差のボールが 0 を含み半径が 2^-200 未満であること（等号）で行い、許容誤差は置かない（共通の準備 `sagemath/_shared/log_integral_by_balls.sage`）。

範囲外のもの:

- 背理法の鎖の 2・3 行目（偽の仮定 r(π) ≤ aπ/2 の下での大小）。仮定を満たす点が無いので、点では確かめられない。両辺に正の数を掛ける操作であることだけを本文で見た。

- 選んだ以外の点。微分の公式・(R3)・(R4)・円周率の数値の評価そのもの（本文が外部から持ち込む事実）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh three_halves_power_integral_bound
```

実行ログは `logs/` に保存する。
