# SageMath Check: arcsinh_argument_is_positive

## 対象

**対象ラベル**: `arcsinh_argument_is_positive` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/020_critical_point.ts`
- ブロック: `critical_claim_arcsinh_argument_is_positive`（y + √(y²+1) > 0）
- 範囲: 準備、p+q の鎖、背理法の三つの含意、主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備 pq = 1（arcsinh_argument_times_conjugate_is_one） | `check_proof_lines.sage` | y の 9 点（±10^6、±10^{-6} を含む）で s を AA の √(y²+1) として厳密に | **PASS** | 成り立つ |
| p+q の鎖 (y+s)+(s-y) = 2s > 0 | `check_proof_lines.sage` | 等号は QQ[y,s] で、> 0 は 9 点の AA で | **PASS** | 成り立つ |
| 背理法の三つの含意 | `check_proof_lines.sage` | QQ の符号の組 25 通りで | **PASS** | 成り立つ |
| 主張 p > 0 | `check_proof_lines.sage` | 9 点の AA で厳密に。対照としてもう一つの根 y - √(y²+1) は負 | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: 等号の行は `QQ` 上の多項式環・有理関数体・剰余環、関数体 `QQ(y)[s]/(s²-y²-1)`、`AA`・`QQbar`、形式冪級数（全次数 14 以下）で確かめた。
- **`ℝ` への脱出（`RealBallField(512)`）**: 不等号の行と主張の点での確認だけ。exp の値が `QQ` に収まらないためである。ボールは本文の exp の部分和に尾の評価を半径として足したもの（共通の準備 `sagemath/_shared/hyperbolic_by_definition.sage`）で、Arb の exp は使わない。arcsinh の値を囲むときだけ Arb の `log`・`sqrt` を使う（本文の log は exp の逆写像で、本文の exp は標準の exp に等しいため）。
- **構成上かならず一致する比較**: 定義を当てはめる行（例えば 1 行目の「cosh の定義」）は、左辺を定義の関数から、右辺を本文の式のまま作って比べており、定義の書き写しの誤りだけを検出する。

範囲外のもの:

- 選んだ以外の点と、全次数 14 を超える項。微分の公式・(R3)・(R4) そのもの（本文が外部から持ち込む実数解析の事実）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh arcsinh_argument_is_positive
```

実行ログは `logs/` に保存する。
