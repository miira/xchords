package cz.versarius.xchords;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Manages set of chord libraries, one is chosen - current.
 * Extension classes should implement loading and saving of the libraries to some kind of recent preferences.
 * Lazy initialization, loads chord libraries when first needed.
 */
public class ChordManager {
	protected static final Logger LOG = LoggerFactory.getLogger(ChordManager.class);
	protected XMLChordLoader loader = new XMLChordLoader();

	/** name of default chord library for robotar - must match chord id! e.g. <chord id='robotar-C'..> */
	public static final String DEFAULT_ROBOTAR = "robotar";
	/** default prefix */
	public static final String USER_PREFIX = "user";
	
	/** List of chord libraries */
	private Map<String, ChordLibrary> chordLibraries = new HashMap<String, ChordLibrary>();
	
	/** Current chosen library */
	private String chosenLibrary;
	
	/** Is the chord manager already initialized? */
	protected boolean initialized;
	
	/** Were there errors during initialization? (load() method) */
	private boolean errors;
	
	/** Only constructs the object */
	public ChordManager() {
		// empty
	}
	
	/** Call init later */
	public synchronized void initialize() {
		// TODO these 4 lines should be in fact in ChordManager
		// 'robotar-' in fact should be 'basic-' as the basic set in original xchords project
		// load default chords
		String result = loadLibrary("/default-chords/robotar-default.xml");
		if (result != null) {
			//this.setChosenLibrary(result);
			initialized = true;
		} else {
			errors = true;
		}
	}

	public Map<String, ChordLibrary> getChordLibraries() {
		return chordLibraries;
	}

	public int getLibrariesCount() {
		return chordLibraries.size();
	}
	
	public ChordLibrary getAny() {
		if (!chordLibraries.isEmpty()) {
			ChordLibrary lib = chordLibraries.get(DEFAULT_ROBOTAR);
			if (lib == null) {
				String libName = chordLibraries.keySet().iterator().next();
				return chordLibraries.get(libName);
			} else {
				return lib;
			}
		}
		return null;
	}
	
	public void setChordLibraries(Map<String, ChordLibrary> chordLibraries) {
		this.chordLibraries = chordLibraries;
		this.initialized = true;
		// TODO check paths of libraries and set 'errors', if they exist? OR remove this method.
	}

	/**
	 * Find chord library in already loaded libraries by name.
	 * O(1)
	 * 
	 * @param libraryName
	 * @return
	 */
	public ChordLibrary findByName(String libraryName) {
		return chordLibraries.get(libraryName);
	}
	
	/**
	 * Find library in loaded libraries by path.
	 * O(n)
	 * 
	 * @param path
	 * @return
	 */
	public ChordLibrary findByPath(String path) {
		Iterator<ChordLibrary> itLibs = chordLibraries.values().iterator();
		while (itLibs.hasNext()) {
			ChordLibrary lib = itLibs.next();
			if (lib.getPath().equals(path)) {
				return lib;
			}
		}
		return null;
	}
	
	/**
	 * Is chord manager instance initialized with chord libraries?
	 * @return
	 */
	public boolean isInitialized() {
		return initialized;
	}

	/**
	 * Was there some problem with loading of chords libraries?
	 * 
	 * @return
	 */
	public boolean isErrors() {
		return errors;
	}
	//TODO 
	/** generate list of used chord libraries without robotar-default-chords. */
	public List<String> getLibrariesList(Collection<ChordLibrary> libs) {
		List<String> list = new ArrayList<String>();
		for (ChordLibrary chl : libs) {
			// ignore robotar collection
			if (!DEFAULT_ROBOTAR.equals(chl.getName())) {
				// skip those, that were not yet saved - we don't have path set
				if (chl.getPath() != null) {
					list.add(chl.getPath());
				}
			}
		}
		return list;
	}

	public boolean isNameAvailable(String libName) {
		Iterator<String> itNames = chordLibraries.keySet().iterator();
		while (itNames.hasNext()) {
			String name = itNames.next();
			if (name.equalsIgnoreCase(libName)) {
				return false;
			}
		}
		return true;
	}

	/** Load content of chord manager from preferences. */
	public void load(List<String> chordLibraries, String chosenLibrary) {
		for (String fileName : chordLibraries) {
			String result = loadLibrary(new File(fileName));
			if (result == null) {
				errors = true;
			}
		}
		setChosenLibrary(chosenLibrary);
	}
	
	/** only for default robotar chords */
	public String loadLibrary(String path) {
		InputStream is = ChordManager.class.getResourceAsStream(path);
		if (is == null) {
			LOG.error("Chord library doesn't exist. local resource path: {}", path);
			return null;
		}
		String lib = loadLibrary(is, path);
		if (lib != null) {
			return lib;
		}
		return null;
	}
	
	/** for all other chord libraries file */
	public String loadLibrary(File file) {
		try {
			// check, if it isn't already loaded in chord manager
			ChordLibrary lib = findByPath(file.getPath()); // ? or abs?
			String libName;
			if (lib == null) {
				// load it
				FileInputStream fis = new FileInputStream(file);
				libName = loadLibrary(fis, file.getPath());
			} else {
				libName = lib.getName();
			}
			if (libName != null) {
				return libName;
			}
		} catch (FileNotFoundException e) {
			LOG.error("Chord library doesn't exist. file path: {}", file.getPath());
		}
		return null;
	}
	
	protected String loadLibrary(InputStream is, String path) {
		ChordLibrary library = new ChordLibrary();
		loader.loadChords(is, library);
		if (library.isEmpty()) {
			// log
			LOG.error("Chord library is empty. Path: {}", path);
			return null;
		}
		
		library.setName(Chord.getLibraryName(library.getFirst().getId()));
		library.setPath(path);
		// check already existing names
		if (isNameAvailable(library.getName())) {
			getChordLibraries().put(library.getName(), library);
			LOG.info("Successfully loaded chord library: {}, path: {}", library.getName(), path);
			
			return library.getName();
		} else {
			LOG.error("Library with name: '{}' already exists in chord manager! Skipping: {}", library.getName(), path);
			return null;
		}
	}

	public String getChosenLibrary() {
		return chosenLibrary;
	}

	public void setChosenLibrary(String libraryName) {
		this.chosenLibrary = libraryName;
	}
	
}
