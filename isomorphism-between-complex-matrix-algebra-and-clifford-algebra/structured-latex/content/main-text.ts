/**
 * 本文の入口。章の並びはこの配列の並びが正本である（構成案の章立ての順）。
 *
 * 章ごとのブロックは `content/chapters/<章名>.ts` に置き、ここで構成案の順に連結する。
 * システムは `content/` 直下のファイル名の昇順を文書順とし、リポジトリの規約はファイル名の連番を禁じるので、
 * 章ファイルを `content/` 直下に並べると、章の順がファイル名の辞書順に化ける。
 * 章を足すときは、`chapters/` にファイルを置き、下の配列の構成案どおりの位置に足す。
 */

import mathematicalToolkit from "./chapters/mathematical-toolkit.ts";

export default [...mathematicalToolkit] as const;
