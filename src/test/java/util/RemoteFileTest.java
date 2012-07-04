package util;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;

import java.util.List;

import org.junit.Test;

public class RemoteFileTest {

	@Test
	public void readRemote() {
		String url = "https://raw.github.com/exmo/equizmo-ws/master/src/test/resources/remote.txt";
		String expectedContent = "this file should be read remotely from github site";
		assertEquals(expectedContent, FileUtil.readRemote(url));
	}
	
	@Test
	public void readRemoteAsList() {
		String url = "https://raw.github.com/exmo/equizmo-ws/master/src/test/resources/remote.txt";
		List<String> sl = FileUtil.readRemoteAsStringList(url);
		String expectedContent = "this file should be read remotely from github site";
		assertEquals(expectedContent, sl.get(0));
	}
	
	@Test
	public void readInvalidRemote() {
		assertNull(FileUtil.readRemote("http://www.nonexisting.url"));
	}	
}
