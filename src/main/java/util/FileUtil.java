package util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class FileUtil {

	public static String readRemote(String url) {
		BufferedReader br = null;
		StringBuilder sb = null;
		try {
			br = new BufferedReader(new InputStreamReader(
					new URL(url).openStream()));
			sb = new StringBuilder();
			String line;
			while ((line = br.readLine()) != null) {
				sb.append(line);
			}
			br.close();
			return sb.toString();
		} catch (IOException e) {
			return null;
		}
	}

	public static List<String> readRemoteAsStringList(String url) {
		BufferedReader br = null;
		List<String> sl = new ArrayList<String>();
		try {
			br = new BufferedReader(new InputStreamReader(
					new URL(url).openStream()));
			String line;
			while ((line = br.readLine()) != null) {
				sl.add(line);
			}
			br.close();
			return sl;
		} catch (IOException e) {
			return null;
		}
	}
}
