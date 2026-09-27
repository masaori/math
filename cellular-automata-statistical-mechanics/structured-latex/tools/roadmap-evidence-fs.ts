/**
 * 段取りの根拠が指すパスの実在を、ディスクの上で判定する。
 *
 * 規則そのもの（`roadmap-rules.ts`）は純関数で持ち、ここだけがファイルシステムに触れる。
 * 判定を `existsSync` 一行で書くと、ディレクトリが「実在する根拠」として通る。ディレクトリは
 * 中身が空でも存在するため、それを根拠と認めると実在の主張が空になる。さらに `statSync` は
 * シンボリックリンクを追跡するため、字面が内側でも外部ファイルを根拠にできる。根拠は
 * プロジェクト内の一次情報そのもの（通常ファイル）を指していなければならない。
 */

import { lstatSync, realpathSync } from "node:fs";
import { isAbsolute, relative, resolve } from "node:path";

/** `projectDir` からの相対パスが、リンクを介さず `projectDir` の内側に通常ファイルとして実在するか。 */
export const evidenceFileExists = (projectDir: string, path: string): boolean => {
  const projectRealPath = realpathSync(projectDir);
  const absolute = resolve(projectRealPath, path);
  const inside = relative(projectRealPath, absolute);
  if (inside === "" || inside.startsWith("..") || isAbsolute(inside)) return false;
  try {
    if (!lstatSync(absolute).isFile()) return false;
    const resolvedInside = relative(projectRealPath, realpathSync(absolute));
    return resolvedInside !== "" && !resolvedInside.startsWith("..") && !isAbsolute(resolvedInside);
  } catch {
    return false;
  }
};
